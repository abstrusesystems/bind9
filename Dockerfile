FROM alpine:latest
LABEL maintainer="github -at- abstruse -dot- systems"

ENV DATA=/srv/bind9

RUN apk add --update --no-cache bind

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp

VOLUME ["${DATA}"]

ENTRYPOINT ["sh","/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named","-g"]
