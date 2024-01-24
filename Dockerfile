# Use a base image with Bash
FROM bash:latest

# Install required packages
RUN apk --no-cache add netcat-openbsd fortune cowsay

# Set environment variables
ENV SRVPORT=4499 \
    RSPFILE=response

# Remove existing response file and create a fifo
RUN rm -f $RSPFILE && mkfifo $RSPFILE

# Copy the Bash script into the container
COPY wisecow.sh /wisecow.sh

# Make the script executable
RUN chmod +x /wisecow.sh

# Expose the specified port
EXPOSE $SRVPORT

# Set the working directory
WORKDIR /

# Run the script when the container starts
CMD ["/bin/bash", "/wisecow.sh"]
