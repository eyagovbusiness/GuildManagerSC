FROM consul

COPY Infrastructure/Consul/docker-entrypoint-override.sh /usr/local/bin/docker-entrypoint-override.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-override.sh

COPY Infrastructure/Consul/consul_init.sh /usr/local/bin/consul_init.sh
RUN chmod +x /usr/local/bin/consul_init.sh

ENTRYPOINT ["docker-entrypoint-override.sh"]
CMD ["agent", "-dev", "-client", "0.0.0.0"]


