FROM golang:1.23.2-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -buildvcs=false -o "SignTools"

FROM alpine:3.20.3

WORKDIR /

COPY --from=builder "/src/SignTools" "/"

ENTRYPOINT ["/SignTools"]
EXPOSE 8080
