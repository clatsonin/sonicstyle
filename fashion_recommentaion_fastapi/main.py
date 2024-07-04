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
        agent = "fashion designer"
        command = """Generate personalized outfit recommendations based on user details.
        Focus on creating stylish and suitable outfits considering the user's preferences, budget, and occasion.
        Your final recommendation should include a complete outfit with accessories. DON'T GIVE MORE THAN THREE RECOMMENDATIONS.
        Highlight the style choices."""

        question = "collect their skin tone, approximate dress size, gender" + question
        json_format = """{
  "response": [
    {
      "Outfit_name": "string",
      "description": "string",
      "style_reason": "string",
      "top": "string",
      "bottom": "string",
      "shoes": "string",
      "accessories": "string"
    },
    {
      "Outfit_name": "string",
      "description": "string",
      "style_reason": "string",
      "top": "string",
      "bottom": "string",
      "shoes": "string",
      "accessories": "string"
    },
    {
      "Outfit_name": "string",
      "description": "string",
      "style_reason": "string",
      "top": "string",
      "bottom": "string",
      "shoes": "string",
      "accessories": "string"
    }
  ]
}"""

        question = f"You are {agent}. Follow these commands {command} for this user {question}. Output in dictionary with this format {json_format}."
        response = model.generate_content(question)
        response = ' '.join(response.text.split())
        # Remove the surrounding square brackets
        if response.startswith('[') and response.endswith(']'):
            response = response[1:-1]
        return response
