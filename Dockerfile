# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set a non-root user
RUN useradd -ms /bin/bash appuser
USER appuser

# Set the working directory
WORKDIR /home/appuser/app

# Copy the requirements file and install dependencies
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY --chown=appuser:appuser . .

# Add health checks
HEALTHCHECK --interval=30s --timeout=3s CMD curl --fail http://localhost:8000/ || exit 1

# Command to run the application
CMD ["python", "app.py"]