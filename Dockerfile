
# Base image
FROM python:3.12-slim

# Install system dependencies (fixed for libindicator7 issue)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    curl \
    ca-certificates \
    fonts-liberation \
    libnss3 \
    libxss1 \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libgtk-3-0 \
    chromium-driver \
    chromium \
    && apt-get clean

# Set environment variables
ENV CHROME_BIN=chromium
ENV PATH="/usr/lib/chromium/:$PATH"

# Set working directory
WORKDIR /app

# Copy files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Streamlit port
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app_bulk_gst_scraper_email.py", "--server.port=8501", "--server.enableCORS=false"]
