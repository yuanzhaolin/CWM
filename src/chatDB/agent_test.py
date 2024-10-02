#!/usr/bin/python
# -*- coding:utf8 -*-

import datetime
from config import cfg

def a():
    print("a")

def b():
    print("b")

tools = [a, b]

from langchain import ChatOpenAI

llm = ChatOpenAI(model="gpt-3.5-turbo-0125", temperature=0)

from langchain import hub

# Get the prompt to use - you can modify this!
prompt = hub.pull("hwchase17/openai-functions-agent")
prompt.messages