FROM nginx:alpine

# Copy our lightweight HTML page
COPY index.html /usr/share/nginx/html/index.html

# Expose HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
