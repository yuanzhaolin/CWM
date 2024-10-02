#!/usr/bin/python
# -*- coding:utf8 -*-
from langchain.tools import tool

# 定义一个类，包含多个需要作为工具的方法
class MathOperations:
    def __init__(self, c: int):
        """初始化时设置常量c"""
        self.c = c

    @tool
    def sum2(self, a: int, b: int) -> int:
        """Return the sum of two integers, multiplied by constant c.

        Args:
            a: The first number.
            b: The second number.
        """
        return (a + b) * self.c

    @tool
    def mul2(self, a: int, b: int) -> int:
        """Return the multiplication of two integers, multiplied by constant c.

        Args:
            a: The first number.
            b: The second number.
        """
        return (a * b) * self.c

    @tool
    def pow1(self, a: int) -> int:
        """Return the square of the integer, multiplied by constant c.

        Args:
            a: The number to square.
        """
        return (a ** 2) * self.c

# 实例化类并获取工具
math_ops = MathOperations(c=10)

tool_list = [math_ops.sum2, math_ops.mul2, math_ops.pow1]

# 你可以在 LangChain Agents 或其他地方使用这些工具
# tool_list is now a list of tools which can be used in tool-based applications

# Example usage:
print(math_ops.sum2(2, 3))  # Output: (2 + 3) * 10 = 50


from langchain.agents import initialize_agent, Tool
from langchain.agents import AgentType
from langchain.llms import OpenAI

# 假设我们有一个 OpenAI LLM 实例
llm = OpenAI()  # LLM used in the agents

# 工具可以来自 `tool_list` 中的工具
tools = [Tool.from_function(func) for func in tool_list]   # Wrapping tools in a Tool object

# 初始化代理
agent = initialize_agent(tools, llm, agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION, verbose=True)

# 使用代理处理输入
output = agent.run("What is the sum of 2 and 3, then multiply by 10?")
print(output)  # Output: Answer will depend on how OpenAI responds