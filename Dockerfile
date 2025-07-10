# ---------- Stage 1: Build binary ----------
FROM python:3.11-slim AS builder

WORKDIR /core

# Install system dependencies including binutils for PyInstaller
RUN apt-get update && apt-get install -y \
    build-essential \
    binutils \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install pyinstaller

# Copy your app code (keep structure clean)
COPY ./core/app.py .

# Generate binary using PyInstaller
RUN pyinstaller --onefile app.py

# ---------- Stage 2: Create minimal image ----------
FROM debian:bullseye-slim

WORKDIR /core

# Copy compiled binary only
COPY --from=builder /core/dist/app /core/app

# Expose FastAPI port
EXPOSE 8000

# Run binary
CMD ["./app"]
