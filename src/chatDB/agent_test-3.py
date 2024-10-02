import getpass
import os
from config import cfg

from langchain.tools import BaseTool
from langchain_core.tools import tool
from langchain_openai import ChatOpenAI
from langchain.chains.conversation.memory import ConversationBufferWindowMemory
from langchain_core.messages import HumanMessage
from langchain.agents import initialize_agent
from langchain.agents import AgentExecutor, create_tool_calling_agent
from langchain_core.prompts import ChatPromptTemplate



model = ChatOpenAI(
    model="gpt-3.5-turbo",
    api_key=cfg.openai_api_key,  # if you prefer to pass api key in directly instaed of using env vars
    base_url=cfg.openai_base_url,
)

response = model.invoke([HumanMessage(content="hi!")])


class MathOperations:
    def __init__(self, c: int):
        """初始化时设置常量c"""
        self.c = c

    @tool(parse_docstring=True)
    def sum2(self, a: int, b: int) -> int:
        """ Return the sum of two integers, multiplied by constant c.

        Args:
            a: The first number.
            b: The second number.
        """
        return (a + b) * self.c

    @tool(parse_docstring=True)
    def mul2(self, a: int, b: int) -> int:
        """ Return the multiplication of two integers, multiplied by constant c.

        Args:
            a: The first number.
            b: The second number.
        """
        return (a * b) * self.c

    @tool(parse_docstring=True)
    def pow1(self, a: int) -> int:
        """ Return the square of the integer, multiplied by constant c.

        Args:
            a: The number to square.
        """
        return (a ** 2) * self.c

    def tools(self):
        return [self.sum2, self.mul2, self.pow1]

math_ops = MathOperations(c=10)

tools_dict = {tool.name: tool for tool in math_ops.tools()}
# tools = [pow1]

conversational_memory = ConversationBufferWindowMemory(
        memory_key='chat_history',
        k=5,
        return_messages=True
)

# agent = initialize_agent(
#     agent='chat-react-description',
#     tools=tools,
#     llm=model,
#     verbose=True,
#     max_iterations=3,
#     early_stopping_method='generate',
#     memory=conversational_memory
# )

agent = model.bind_tools(math_ops.tools())
prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You are a mathematical assistant. Several tools are available to you."),
        ("human", "{input}"),
        # Placeholders fill up a **list** of messages
        ("placeholder", "{agent_scratchpad}"),
    ]
)


agent = create_tool_calling_agent(model, math_ops.tools(), prompt)
agent_executor = AgentExecutor(agent=agent, tools=math_ops.tools())


questions = [
    'what is 2 + 2',
    'what is 3 * 3',
    'What if change * to + ?'
]

# messages = []

for question in questions:
    # message = agent.invoke({"input": question})
    message = agent_executor.invoke({"input": question})
    print(message)
    # ai_msg = agent.invoke([HumanMessage(question)])
    # for tc in ai_msg.tool_calls:
    #     messages.append(tools_dict[tc['name']].invoke(tc))

    # response = agent.invoke(HumanMessage(question))
    # print(response)

# print(messages)




