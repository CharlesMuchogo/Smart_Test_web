# Use an official Ubuntu image as a parent image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Set up Flutter
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy the Flutter project
COPY . /app
WORKDIR /app

# Get Flutter packages
RUN flutter pub get

# Build the app for the web
RUN flutter build web

# Copy the built app to the Nginx html directory
RUN cp -R build/web/* /var/www/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
