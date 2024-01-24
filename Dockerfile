# Use a lightweight base image
FROM alpine:latest

# Add the "community" repository
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install necessary packages
RUN apk --no-cache add netcat-openbsd fortune cowsay

# Set the working directory
WORKDIR /app

# Copy the script into the container
COPY wisecow.sh /app/wisecow.sh

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Expose the port used by the application
EXPOSE 4499

# Run the application
CMD ["/app/wisecow.sh"]
