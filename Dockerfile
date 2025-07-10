# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /core

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your FastAPI app code
COPY ./core ./core

# Expose FastAPI port
EXPOSE 8000

# Run the app using uvicorn
CMD ["python", "core/app.py"]
