# Uses the Nginx image from Docker Hub
FROM nginx:alpine

COPY src/index.html /usr/share/nginx/html/
COPY src/index.css /usr/share/nginx/html/

COPY src/images/ /usr/share/nginx/html/images/

# Exposing port 80
EXPOSE 80

# Start Nginx when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]

