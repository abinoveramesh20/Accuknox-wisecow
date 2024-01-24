# Use a base image with a minimal installation of Linux
FROM alpine:latest

# Install required packages
RUN apk --no-cache add netcat-openbsd fortune \
    && apk --no-cache add --virtual .build-deps curl \
    && curl -sSL https://github.com/tnalpgge/rankmirrors/raw/master/alpine3.13/main/mirrors.yaml -o /etc/apk/repositories \
    && apk add --no-cache cowsay \
    && apk del .build-deps

# Set the working directory
WORKDIR /app

# Copy the script into the container
COPY wisecow.sh /app/wisecow.sh

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Expose the port that the application listens on
EXPOSE 4499

# Run the application when the container starts
CMD ["/app/wisecow.sh"]
