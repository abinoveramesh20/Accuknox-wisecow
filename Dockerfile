# Use a base image with the desired Linux distribution
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Install necessary packages (cowsay and fortune) using the package manager of the base image
RUN apk add --no-cache fortune cowsay netcat-openbsd

# Copy the Wisecow script into the container
COPY wisecow.sh /app/wisecow.sh

# Set execute permissions on the script
RUN chmod +x /app/wisecow.sh

# Expose the port that the application listens on
EXPOSE 4499

# Define the command to run when the container starts
CMD ["/app/wisecow.sh"]
