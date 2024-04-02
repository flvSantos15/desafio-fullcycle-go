# FROM alpine:latest AS stage1

# WORKDIR /
# COPY go.mod .
# COPY hello.go .

# RUN apk add --no-cache go
# RUN go build -o /hello-world.go

# FROM scratch AS stage2
# WORKDIR /
# COPY --from=stage1 ./hello.go ./
# # CMD ["go", "run", "hello"]
# CMD ["/hello"]

FROM golang:alpine3.15 AS builder

WORKDIR /app

COPY go.mod ./
# COPY hello.go ./
RUN go mod download

COPY *.go ./

RUN go build -o /hello-world-go

# # CMD ["go", "run", "hello.go"]

FROM scratch
COPY --from=builder /hello-world-go /hello-world-go
CMD [ "/hello-world-go" ]
# WORKDIR /usr/src/app
# # RUN rm -rf /usr/src/app
# COPY --from=build /usr/src/app /usr/src/app
