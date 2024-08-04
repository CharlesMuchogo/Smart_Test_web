# Stage 1: Build the Flutter web app
FROM alpine:latest AS build

# Install dependencies
RUN apk add --no-cache bash curl git openjdk11-jdk

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH="/usr/lib/jvm/java-11-openjdk/bin:/flutter/bin:${PATH}"

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
RUN flutter/bin/flutter doctor

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

# Expose port 8080
EXPOSE 8080

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
