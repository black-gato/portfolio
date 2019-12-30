FROM alpine:latest AS build

ENV HUGO_VERSION 0.61.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

RUN mkdir /usr/local/hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/hugo/
RUN tar xzf /usr/local/hugo/${HUGO_BINARY}.tar.gz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && rm /usr/local/hugo/${HUGO_BINARY}.tar.gz

WORKDIR /src
COPY . /src
RUN hugo

FROM nginx:latest

COPY --from=build /src/public /usr/share/nginx/html

EXPOSE 80
