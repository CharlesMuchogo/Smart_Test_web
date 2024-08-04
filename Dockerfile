# Stage 1: Build the Flutter web app
FROM debian:latest AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash curl git openjdk-11-jdk unzip xz-utils zip libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the Flutter project files to the container
COPY . .

# Enable web support and build the web app
RUN flutter/bin/flutter config --enable-web
RUN flutter/bin/flutter build web

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
