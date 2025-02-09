FROM registry.astralinux.ru/astra/ubi18
ARG UID=1001
ARG GID=1001
# add our user and group first to make sure their IDs get assigned consistently, regardless of wh>
RUN groupadd -r unbound -g ${GID} && useradd -u ${UID} -c "systemuser for unbound service" -r -g unbound unbound -d /unbound
WORKDIR /unbound
RUN chown -R unbound:unbound /unbound

RUN apt update;apt install -y unbound;rm -rf /var/lib/apt/lists/*;
VOLUME     [ "/unbound" ]
EXPOSE 53 853 443
COPY unbound.conf /etc/unbound/
CMD ["/usr/sbin/unbound", "-d", "-c", "/etc/unbound/unbound.conf"]
