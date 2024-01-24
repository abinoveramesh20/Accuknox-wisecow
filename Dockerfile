# Use a base image with the desired Linux distribution
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Enable the community repository and install necessary packages (fortune and netcat-openbsd)
RUN apk update && apk add --no-cache fortune netcat-openbsd

# Download and install cowsay manually
RUN wget -O /usr/bin/cowsay https://github.com/tnalpgge/rank-amateur-cowsay/raw/master/cowsay && \
    chmod +x /usr/bin/cowsay

# Copy the Wisecow script into the container
COPY wisecow.sh /app/wisecow.sh

# Set execute permissions on the script
RUN chmod +x /app/wisecow.sh

# Expose the port that the application listens on
EXPOSE 4499

# Define the command to run when the container starts
CMD ["/app/wisecow.sh"]
