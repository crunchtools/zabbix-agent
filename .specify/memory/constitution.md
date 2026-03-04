# zabbix-agent Constitution

> **Version:** 1.0.0
> **Ratified:** 2026-03-04
> **Status:** Active
> **Inherits:** [crunchtools/constitution](https://github.com/crunchtools/constitution) v1.0.0
> **Profile:** Container Image

Zabbix Agent2 7.0 on UBI 10 Minimal for host monitoring. Replaces the upstream `docker.io/zabbix/zabbix-agent2` Oracle Linux image with a consistent UBI 10 base. Runs privileged with `--network=host --pid=host` on Lotor for full system visibility.

---

## License

AGPL-3.0-or-later

## Versioning

Follow Semantic Versioning 2.0.0. MAJOR/MINOR/PATCH.

## Base Image

`registry.access.redhat.com/ubi10/ubi-minimal` — agent2 is a single Go binary, no systemd needed.

## Registry

Published to `quay.io/crunchtools/zabbix-agent`.

## Containerfile Conventions

- Uses `Containerfile` (not Dockerfile)
- Required LABELs: `maintainer`, `description`
- `microdnf install -y` followed by `microdnf clean all`
- No RHSM required — Zabbix 7.0 repo is public
- `ENTRYPOINT ["/usr/sbin/zabbix_agent2", "-f", "-c", "/etc/zabbix/zabbix_agent2.conf"]`

## Packages Installed

shadow-utils, zabbix-agent2

## Configuration

Default config at `/etc/zabbix/zabbix_agent2.conf` with include directory at `/etc/zabbix/zabbix_agent2.d/*.conf` for per-host overrides via volume mounts.

## Runtime

- `--network=host --pid=host --privileged` — full system monitoring access
- Host config override bind-mounted from `/srv/zabbix-agent.crunchtools.com/config/`
- Podman socket mounted for container monitoring
- Host filesystem mounted read-only at `/host/rootfs`

## Testing

- **Static tests**: verify packages, config, entrypoint, binary
- **Runtime tests**: verify agent2 starts and listens on port 10050
- **Security scan**: Trivy CRITICAL/HIGH (continue-on-error)

## Quality Gates

1. Static tests — image contents verified
2. Runtime tests — agent starts and listens
3. Trivy scan — vulnerability report
4. Weekly rebuild — cron job picks up base image updates every Monday 6 AM UTC
