FROM klakegg/hugo:latest AS HugoBuild
WORKDIR /src
COPY . /src
RUN hugo 


FROM nginx:latest
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=HugoBuild /src/public /usr/share/nginx/html

EXPOSE 80
