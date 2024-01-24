# Use a base image with a minimal installation of Linux
FROM alpine:latest

# Install required packages
RUN apk --no-cache add netcat-openbsd
RUN apk --no-cache add fortune
RUN apk --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add cowsay

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
