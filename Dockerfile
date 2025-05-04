# Use an official Python runtime as the base image
FROM python:3.13-slim-bookworm

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter Lab and extensions for VSCode compatibility
RUN pip install --no-cache-dir \
    jupyterlab \
    jupyter_server \
    ipykernel \
    jupyter-lsp \
    python-lsp-server \
    jupyterlab-git

# Create directory for notebooks
RUN mkdir -p /app/notebooks

# Expose the ports for Jupyter and Dash
EXPOSE 8888 8050

# Command to run Jupyter Lab - this is overridden by docker-compose
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
