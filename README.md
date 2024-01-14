# A docker compose for docker_state_exporter

## Dependencies

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose plugin](https://docs.docker.com/compose/install/linux/)

## Installation

```bash
git clone https://github.com/denysrondaliev/docker-state-exporter-compose.git
cd docker-state-exporter-compose/
docker compose up -d --build
```

## Testing

```bash
wget -q -O - localhost:9100/metrics | grep -q "container_restartcount"
```

## Uses the following Docker containers

- https://github.com/karugaru/docker_state_exporter

## 📝 License

This project is licensed under the [MIT License](LICENSE).
