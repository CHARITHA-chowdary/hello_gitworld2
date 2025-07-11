# Use official slim Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /core

# Install system build tools needed for compiling packages
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    python3-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel (good practice for pyproject builds)
RUN pip install --upgrade pip setuptools wheel

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your FastAPI app code
COPY ./core ./core

# Expose FastAPI port
EXPOSE 8000

# Run the app using Python
CMD ["python", "core/app.py"]
