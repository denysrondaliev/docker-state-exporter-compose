#! /bin/sh

/usr/sbin/awall activate -f
/go/bin/docker_state_exporter -listen-address=:8080
