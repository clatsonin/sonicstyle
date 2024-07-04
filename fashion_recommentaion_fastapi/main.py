#Setup Environment Variables
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("GOOGLE_API_KEY")
if not api_key:
    raise ValueError("GOOGLE_API_KEY is not set in the environment variables")

#Install Required Packages
#pip install fastapi pydantic uvicorn python-dotenv google-generativeai
