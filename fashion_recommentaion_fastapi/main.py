#Setup Environment Variables
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("GOOGLE_API_KEY")
if not api_key:
    raise ValueError("GOOGLE_API_KEY is not set in the environment variables")

#Install Required Packages
#pip install fastapi pydantic uvicorn python-dotenv google-generativeai

#Configure the Google Generative AI Client
import google.generativeai as genai

genai.configure(api_key=api_key)

#Initialize FastAPI
from fastapi import FastAPI, HTTPException

app = FastAPI()

#Define the Request Model
from pydantic import BaseModel

class QuestionRequest(BaseModel):
    question: str

#Define the Function to Get Gemini Response

def get_gemini_response(question: str) -> str:
    model = genai.GenerativeModel('gemini-pro')
    response = model.generate_content(question)
    return response
