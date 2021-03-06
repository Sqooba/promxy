FROM       golang:alpine as builder

COPY . /go/src/github.com/jacksontj/promxy
RUN cd /go/src/github.com/jacksontj/promxy/cmd/promxy && CGO_ENABLED=0 go build
RUN cd /go/src/github.com/jacksontj/promxy/cmd/remote_write_exporter && CGO_ENABLED=0 go build

FROM scratch
MAINTAINER Thomas Jackson <jacksontj.89@gmail.com>
EXPOSE     8081

COPY --from=builder /go/src/github.com/jacksontj/promxy/cmd/promxy/promxy /bin/promxy
COPY --from=builder /go/src/github.com/jacksontj/promxy/cmd/remote_write_exporter/remote_write_exporter /bin/remote_write_exporter

ENTRYPOINT [ "/bin/promxy" ]

