# syntax=docker/dockerfile:1
FROM alpine AS build
ARG SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-0}
ARG TZ ${TZ:-UTC}
ARG LANG ${LANG:-en_US.UTF-8}

ENV TZ=${TZ:-UTC}
ENV LANG=${LANG:-en_US.UTF-8}
ENV LANGUAGE=${LANG}
ENV LC_ALL=${LANG}
RUN echo ${TZ} > /etc/timezone

RUN apk add --no-cache ca-certificates tzdata shadow openvpn iptables
RUN mkdir -p /etc/openvpn/ccd
RUN echo tun >>/etc/modules
COPY ./docker-entrypoint.sh /

FROM build
ARG SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-0}
COPY --from=build / /

ARG TZ ${TZ:-UTC}
ARG LANG ${LANG:-en_US.UTF-8}
ENV TZ=${TZ:-UTC}
ENV LANG=${LANG:-en_US.UTF-8}

ENTRYPOINT ["/docker-entrypoint.sh"]
HEALTHCHECK --interval=35s --timeout=4s CMD /docker-entrypoint.sh health
