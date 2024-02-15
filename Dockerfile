FROM python:3.11-slim

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    POETRY_VERSION=1.7.0

# Install Poetry
RUN pip install poetry==$POETRY_VERSION

WORKDIR /app

# Copy only the files necessary for installing dependencies to cache the layers better
COPY pyproject.toml poetry.lock ./

# Use Poetry to install dependencies
# Note: No need to create a virtual environment inside Docker since Docker itself provides isolation
RUN poetry install --no-dev --no-root

# Copy the rest of your application code
COPY . .

# After copying your application files
RUN chmod +x /app/app.py

# Optionally, if your project generates a package, install it
WORKDIR /app/
RUN poetry install

# Add the Poetry environment's bin directory to the PATH
ENV PATH="$PATH:/app/.venv/bin"

# ENTRYPOINT ["python", "app.py"]
CMD ["bash"]