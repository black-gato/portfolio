FROM klakegg/hugo:0.62.0 AS build
WORKDIR /src
COPY . /src
RUN hugo

EXPOSE 1313

ENTRYPOINT ["hugo"]