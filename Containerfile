FROM quay.io/crunchtools/ubi10-core:latest

LABEL maintainer="fatherlinux <scott.mccarty@crunchtools.com>"
LABEL description="Zabbix Agent2 7.0 on UBI 10 for host monitoring"
LABEL org.opencontainers.image.source=https://github.com/crunchtools/zabbix-agent
LABEL org.opencontainers.image.description="Zabbix Agent2 7.0 on UBI 10 — host monitoring container"
LABEL org.opencontainers.image.licenses=AGPL-3.0-or-later

# Copy Zabbix repo and default config
COPY rootfs/ /

# zabbix-agent2 available in Zabbix repo (added via rootfs)
RUN dnf install -y zabbix-agent2 && \
    dnf clean all

# Enable zabbix-agent2 as a systemd service
RUN systemctl enable zabbix-agent2

EXPOSE 10050
