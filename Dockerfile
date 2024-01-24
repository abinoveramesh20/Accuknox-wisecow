# Use Alpine Linux as the base image
FROM alpine:latest

# Set the working directory
WORKDIR /wisecow

# Copy the application code into the container
COPY . .

# Install cowsay and fortune
RUN apk add --no-cache cowsay fortune

# Expose the port used by the application
EXPOSE 4499

# Define the entry point command
CMD ["./wisecow.sh"]
