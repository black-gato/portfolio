FROM klakegg/hugo:0.62.0 AS HugoBuild
WORKDIR /src
COPY . /src
RUN hugo 


FROM nginx:latest
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=HugoBuild /src/public /usr/share/nginx/html

# The container will listen on port 80 using the TCP protocol.
EXPOSE 80
