FROM consul

EXPOSE 8000

COPY Infrastructure/Consul/docker-entrypoint-override.sh /usr/local/bin/docker-entrypoint-override.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-override.sh

COPY Infrastructure/ServiceAwait/wait_for_service.sh /usr/local/bin/wait_for_service.sh
RUN chmod +x /usr/local/bin/wait_for_service.sh

COPY Infrastructure/ServiceAwait/IsReadyServer.sh /usr/local/bin/IsReadyServer.sh
RUN chmod +x /usr/local/bin/IsReadyServer.sh

COPY Infrastructure/Consul/consul_init.sh /usr/local/bin/consul_init.sh
RUN chmod +x /usr/local/bin/consul_init.sh

ENTRYPOINT ["docker-entrypoint-override.sh"]
CMD ["agent", "-dev", "-client", "0.0.0.0"]


