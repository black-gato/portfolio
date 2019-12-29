FROM klakegg/hugo:0.62.0 AS build
WORKDIR /src
COPY . /src
RUN hugo -v --source=/src --destination=/src/public

# Install NGINX and deactivate NGINX's default index.html file.
# Move the static site files to NGINX's html directory.
# This directory is where the static site files will be served from by NGINX.
FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY  /src/public/ /usr/share/nginx/html/

# The container will listen on port 80 using the TCP protocol.
EXPOSE 80
