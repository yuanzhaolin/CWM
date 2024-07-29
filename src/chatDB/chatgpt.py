import time
import os
from openai import OpenAI
from colorama import Fore
from config import cfg

client = OpenAI(
    api_key=os.environ.get("OPENAI_API_KEY"),
    base_url="https://api.chatanywhere.tech/v1"
)

def create_chat_completion(messages, model=cfg.fast_llm_model, temperature=cfg.temperature, max_tokens=None, response_format=None) -> str:
    """Create a chat completion using the OpenAI API"""
    num_retries = 5
    for attempt in range(num_retries):
        try:
            params = {
                "model": model,
                "messages": messages,
                "temperature": temperature,
            }
            if max_tokens is not None:
                params["max_tokens"] = max_tokens
            if response_format == "json_object":
                params["response_format"] = {"type": "json_object"}
            
            completion = client.chat.completions.create(**params)
            return completion.choices[0].message.content
        except client.RateLimitError:
            if cfg.debug_mode:
                print(Fore.RED + "Error: ", "API Rate Limit Reached. Waiting 20 seconds..." + Fore.RESET)
            time.sleep(20)
        except client.APIError as e:
            if e.status_code == 502:
                if cfg.debug_mode:
                    print(Fore.RED + "Error: ", "API Bad gateway. Waiting 20 seconds..." + Fore.RESET)
                time.sleep(20)
            else:
                raise
        except client.BadRequestError:
            raise

    raise RuntimeError("Failed to get response after 5 retries")
