# build image
FROM golang:alpine as builder

ENV DOCKER_API_VERSION=1.43

COPY *.go $GOPATH/src/mypackage/myapp/

WORKDIR $GOPATH/src/mypackage/myapp/

RUN apk update && apk add --no-cache git ca-certificates && \
    go mod init && \
    go get google.golang.org/genproto/... && \
    go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/docker_state_exporter

# runtime image
FROM alpine:3

ENV DOCKER_API_VERSION=1.43

COPY --from=builder /go/bin/docker_state_exporter /go/bin/docker_state_exporter
COPY awall/optional /etc/awall/optional
COPY entrypoint.sh /

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ip6tables iptables openssl ca-certificates && \
    apk add --no-cache -u awall && \
    awall enable main && \
    update-ca-certificates && \
    chmod +x+x+x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]
