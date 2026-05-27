import openai

def count_tokens(text):
    """
    计算文本中的token数量
    :param text: 输入的文本
    :return: token数量
    """
    # 使用OpenAI的GPT-3模型来计算token数量
    response = openai.Completion.create(
        engine="text-davinci-002",
        prompt=text,
        max_tokens=1  # 这里只需要计算token数量，不需要生成文本
    )
    return len(response.choices[0].logprobs.token_log_probs)

def display_token_count(text):
    """
    显示当前使用的token数量
    :param text: 输入的文本
    """
    token_count = count_tokens(text)
    print(f"当前使用的token数量: {token_count}")

# 示例用法
if __name__ == "__main__":
    sample_text = "这是一个示例文本。"
    display_token_count(sample_text)
