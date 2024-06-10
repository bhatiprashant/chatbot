from model import LLMModel
from llama_index.core import SimpleDirectoryReader
from llama_index.core import Document

# Load Document
documents = SimpleDirectoryReader(
    input_files = ["./documents/brd.pdf"]
).load_data()
documents = Document(text = "\n\n".join([doc.text for doc in documents]))

# Model path
model_path = "./models/mistral-7b-instruct-v0.2.Q5_K_S.gguf"

# Initialize Chatbot
chatbot = LLMModel(model_path)

# Build Vecotor Index
vector_index = chatbot.get_build_index(documents, "./vector_store/index")

# Setup Query Engine
query_engine = chatbot.get_query_engine(vector_index)

# Query the model
while True:
    query=input("ask your query:")
    response = query_engine.query(query)
    print(response)
    print("\n")

