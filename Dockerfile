# First instruction to install python. slim has been changed to alpine since its sized were smaller.
FROM python:3.12-alpine AS builder
# Execute the commands on top of the image as a new layer
RUN python -m venv /opt/venv
# Enviroment 
ENV PATH="/opt/venv/bin:$PATH"
# Copy the requirements from this file that is mentionend
COPY requirements.txt .
# Execute
RUN pip install --no-cache-dir -r requirements.txt



FROM python:3.12-alpine AS runtime
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=true \
    PYTHONUNBUFFERED=true
# Use this command to create a user (appuser)
# here, we are adding a user with an ID 1000 inside the img
RUN adduser -D -u 1000 appuser

# The workdirectory for the subsequent.
WORKDIR /app
# chown = change the ownership of /app
# This makes it sure that the user has access to read and write in /app
RUN chown appuser:appuser /app

# Copy the content form builder. 
# This helps to keep the images size to use less space
COPY --from=builder /opt/venv /opt/venv
# Copy the ownership for app user to ensure the non-root user still can access and modify files
COPY --chown=appuser:appuser . .

#Set default user for the remaining isntructions in the Dockerfile and for the running container to appuser
# This security helps to avoiding running as root
USER appuser

# for the non-root user (appuser), the app will listen to the port 5000, not opening it
# 5000 is also Flasks standart
EXPOSE 5000
# Provides default for the executing container. There can only be one CMD instruction in a file
# & Wrapper script has been created to execute with a JSON-formatted ENTRYPOINT command.
# Can be good when the entrypoint uses JSON format. Otherwise, use explicitly the shell.
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]