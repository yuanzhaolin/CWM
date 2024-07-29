from chatgpt import create_chat_completion
from recall_knowledge import retrive_standard_entity_names
from config import cfg
from extract_entity import extract_entities



def generate_standard_entity_mapping(entities):
    mapping = []
    entity_mapping_template = f"""
    - entity_name: {{entity_name}}
      entity_type: {{entity_type}}
      possible_standard_entity_names: {{possible_standard_names}}
    """
    for entity_type, entity_list in entities.items():
        if entity_list:
            for entity_name in entity_list:
                possible_standard_names = ", ".join(retrive_standard_entity_names(entity_type, entity_name))
                if possible_standard_names:
                    mapping.append(entity_mapping_template.format(entity_type=entity_type, entity_name=entity_name, possible_standard_names=possible_standard_names))
    return "\n".join(mapping)

def rewrite_query(question):
    """
    使用ChatGPT对输入的问题进行优化，替换实体名称为标准实体名称。
    
    :param question: 输入的问题
    :return: 优化后的问题
    """
    entities = extract_entities(question)
    print("\n***********extracted entities***********\n", entities)
    standard_entity_mapping = generate_standard_entity_mapping(entities)
    # 如果没有标准实体，直接返回原问题
    if not standard_entity_mapping:
        print("\n***********no standard entity mapping, return orginal question***********\n", question)
        return question
    rewrite_query_prompt = f"""
    # role
    你是专业的问题优化模型，你能够把问题中实体名称替换为标准的实体名称。

    # 标准实体名称
    实体名称与可能的标准实体名称对应关系如下
    '''
    {standard_entity_mapping}
    '''

    # 输出要求
    1. 把实体名称转换为可能性最大的标准实体名称
    2. 使用 "<entity_type = standard_entity_name>"替换原来的实体名称

    # 输出例子
    1. 原问题：
    港理工大学的订单
    改写后的问题：
    <customers.customer_name = 'PolyU'> 的订单
    2. 原问题：
    使用丝绸的缝纫任务有哪些
    改写后的问题：
    使用<products.product_name = 'Silk'> 的缝纫任务有哪些
    3. 原问题：
    主仓库有什么
    改写后的问题：
    <warehouse.warehouse_name = 'Main Warehouse'> 有什么
    
    # 原问题
    {question}

    # 改写后的问题
    """
    print("\n***********rewrite query prompt***********\n", rewrite_query_prompt)
    messages = [
        {"role": "system", "content": "You are a question optimization model."},
        {"role": "user", "content": rewrite_query_prompt}
    ]
    
    optimized_question = create_chat_completion(messages, model=cfg.smart_llm_model)
    print("\n***********optimized question***********\n", optimized_question)
    return optimized_question.strip()

# 示例使用
if __name__ == "__main__":
    original_question = "港大1月的订单包含哪些产品？"
    optimized_question = rewrite_query(original_question)
    print(f"原始问题: {original_question}")
    print(f"优化后的问题: {optimized_question}")
