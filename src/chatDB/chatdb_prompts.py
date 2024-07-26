from langchain.prompts import PromptTemplate
# from sql_examples_bak import egs

# load the examples from the sql_examples/*files in the same directory
import os
egs = []
sql_examples_dir = os.path.join(os.path.dirname(__file__), "sql_examples")
for file in os.listdir(sql_examples_dir):
    if file.endswith(".sql") or file.endswith(".txt"):
        with open(os.path.join(sql_examples_dir, file), "r") as f:
            egs.append(f.read())



prompt_ask_steps_temp = """
Please tell me what standard SQL statements should I use in order to respond to the "USER INPUT". \
If it needs multiple SQL operations on the database, please list them step by step concisely. \
If there is no need to use the database, reply to the "USER INPUT" directly.
The output should be a markdown code snippet formatted in the following schema, \
including the leading and trailing "\`\`\`" and "\`\`\`":
```
Step1: <Description of first step>
`SQL command for step1`

Step2: <Description of second step>
`SQL command for step2`

......
```

Backticks are important and must be added at the beginning and end of the SQL command for every step!

Here are some examples:
{egs}

USER INPUT: {user_inp}
ANSWER:
"""

prompt_ask_steps = PromptTemplate(
        template=prompt_ask_steps_temp,
        input_variables=["user_inp"],
        partial_variables={
            "egs": '\n'.join(egs),
            # "egs": ""
        }
    )

prompt_ask_steps_no_egs = PromptTemplate(
        template=prompt_ask_steps_temp,
        input_variables=["user_inp"],
        partial_variables={
            "egs": ""
        }
    )


if __name__ == '__main__':
    print(prompt_ask_steps.format(user_inp="Hi"))
