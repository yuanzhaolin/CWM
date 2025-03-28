import time
import openai
from dotenv import load_dotenv
from config import Config
import token_counter
from chatgpt import create_chat_completion
from logger import logger
import logging

cfg = Config()


def create_chat_message(role, content):
    """
    Create a chat message with the given role and content.

    Args:
    role (str): The role of the message sender, e.g., "system", "user", or "assistant".
    content (str): The content of the message.

    Returns:
    dict: A dictionary containing the role and content of the message.
    """
    return {"role": role, "content": content}


def generate_context(prompt, relevant_memory, full_message_history, model):
    current_context = [
        create_chat_message(
            "system", prompt),
        create_chat_message(
            "system", f"The current time and date is {time.strftime('%c')}"),
        # create_chat_message(
        #     "system", f"This reminds you of these events from your past:\n{relevant_memory}\n\n"),
    ]

    # Add messages from the full message history until we reach the token limit
    next_message_to_add_index = len(full_message_history) - 1
    insertion_index = len(current_context)
    # Count the currently used tokens
    current_tokens_used = token_counter.count_message_tokens(current_context, "gpt-3.5-turbo")
    return next_message_to_add_index, current_tokens_used, insertion_index, current_context

def generate_abstract_context(user_inp, response, model, old_abstract, token_limit):
    contexts = [
        create_chat_message("system",
        'Please generate an abstract based on the prior conversation context and the older context abstract. '
        'The abstract should be organized as a key-value table that incorporates significant entity information '
        'and records retrieved from the database.'),
        create_chat_message("user", f"The user input: \n {user_inp}"),
        create_chat_message("user", f"The response: \n {response}"),
        create_chat_message("user", f"The old context abstract: \n{old_abstract}")
    ]
    tokens_remaining = token_limit - token_counter.count_message_tokens(contexts, "gpt-4")  #
    assistant_reply = create_chat_completion(
        model=model,
        messages=contexts,
        max_tokens=tokens_remaining,
    )
    return assistant_reply

def generate_final_response(user_inp, sql_resutls, model, token_limit):
    from cwm_prompts import prompt_summary_final_response
    contexts = [create_chat_message("user", prompt_summary_final_response.format(user_inp=user_inp, sql_results=str(sql_resutls)))]
    tokens_remaining = token_limit - token_counter.count_message_tokens(contexts, "gpt-4")  #
    return create_chat_completion(
        model=model,
        messages=contexts,
        max_tokens=tokens_remaining,
    )

def generate_intermediate_thought(operation_str, results_history, model, token_limit):
    from cwm_prompts import prompt_intermediate_thought
    contexts = [create_chat_message("user", prompt_intermediate_thought.format(operation_str=operation_str, sql_results=results_history))]
    tokens_remaining = token_limit - token_counter.count_message_tokens(contexts, "gpt-4")  #
    return create_chat_completion(
        model=model,
        messages=contexts,
        max_tokens=tokens_remaining,
    )

# TODO: Change debug from hardcode to argument
def chat_with_ai(
        prompt,
        user_input,
        full_message_history,
        permanent_memory,
        token_limit):
    """Interact with the OpenAI API, sending the prompt, user input, message history, and permanent memory."""
    while True:
        try:
            """
            Interact with the OpenAI API, sending the prompt, user input, message history, and permanent memory.

            Args:
            prompt (str): The prompt explaining the rules to the AI.
            user_input (str): The input from the user.
            full_message_history (list): The list of all messages sent between the user and the AI.
            permanent_memory (Obj): The memory object containing the permanent memory.
            token_limit (int): The maximum number of tokens allowed in the API call.

            Returns:
            str: The AI's response.
            """
            model = cfg.smart_llm_model  # TODO: Change model from hardcode to argument
            # Reserve 1000 tokens for the response

            send_token_limit = token_limit - 1000

            # relevant_memory = '' if len(full_message_history) ==0 else  permanent_memory.get_relevant(str(full_message_history[-9:]), 10)

            # logger.debug(f'Memory Stats: {permanent_memory.get_stats()}')
            relevant_memory = None

            next_message_to_add_index, current_tokens_used, insertion_index, current_context = generate_context(
                prompt, relevant_memory, full_message_history, model)

            # while current_tokens_used > 2500:
            #     # remove memories until we are under 2500 tokens
            #     relevant_memory = relevant_memory[1:]
            #     next_message_to_add_index, current_tokens_used, insertion_index, current_context = generate_context(
            #         prompt, relevant_memory, full_message_history, model)

            current_tokens_used += token_counter.count_message_tokens([create_chat_message("user", user_input)], "gpt-4") # Account for user input (appended later)

            while next_message_to_add_index >= 0:
                # print (f"CURRENT TOKENS USED: {current_tokens_used}")
                message_to_add = full_message_history[next_message_to_add_index]

                tokens_to_add = token_counter.count_message_tokens([message_to_add], "gpt-3.5-turbo")
                if current_tokens_used + tokens_to_add > send_token_limit:
                    break

                # Add the most recent message to the start of the current context, after the two system prompts.
                current_context.insert(insertion_index, full_message_history[next_message_to_add_index])

                # Count the currently used tokens
                current_tokens_used += tokens_to_add

                # Move to the next most recent message in the full message history
                next_message_to_add_index -= 1

            # Append user input, the length of this is accounted for above
            current_context.extend([create_chat_message("user", user_input)])

            # Calculate remaining tokens
            tokens_remaining = token_limit - current_tokens_used
            # assert tokens_remaining >= 0, "Tokens remaining is negative. This should never happen, please submit a bug report at https://www.github.com/Torantulino/Auto-GPT"

            # Debug print the current context
            # logger.debug(f"Token limit: {token_limit}")
            # logger.debug(f"Send Token Count: {current_tokens_used}")
            # logger.debug(f"Tokens remaining for response: {tokens_remaining}")
            # logger.debug("------------ CONTEXT SENT TO AI ---------------")
            # for message in current_context:
            #     # Skip printing the prompt
            #     # if message["role"] == "system" and message["content"] == prompt:
            #     #     continue
            #     logger.debug(f"{message['role'].capitalize()}: {message['content']}")
            #     logger.debug("")
            # logger.debug("----------- END OF CONTEXT ----------------")

            # TODO: use a model defined elsewhere, so that model can contain temperature and other settings we care about
            # print(current_context)
            assistant_reply = create_chat_completion(
                model=model,
                messages=current_context,
                max_tokens=tokens_remaining,
            )

            # Update full message history
            full_message_history.append(create_chat_message("user", user_input))
            full_message_history.append(create_chat_message("assistant", assistant_reply))
            # logger.debug(f"{full_message_history[-1]['role'].capitalize()}: {full_message_history[-1]['content']}")
            # logger.debug("----------- END OF RESPONSE ----------------")
            return assistant_reply
        except openai.error.RateLimitError:
            # TODO: When we switch to langchain, this is built in
            print("Error: ", "API Rate Limit Reached. Waiting 10 seconds...")
            time.sleep(10)


if __name__ == '__main__':
    cfg.set_debug_mode(False)
    full_msg_history = []
    while True:
        user_inp = input()
        chat_with_ai("You are ChatDB.", user_inp, full_msg_history, None, 1100)
