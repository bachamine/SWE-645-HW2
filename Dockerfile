# Step 1: Use the official Nginx base image
FROM nginx:alpine

# Step 2: Copy your HTML file into the default directory for Nginx
COPY index.html /usr/share/nginx/html/

# Step 3: Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Step 4: Expose port 8080 to allow external traffic
EXPOSE 8080
