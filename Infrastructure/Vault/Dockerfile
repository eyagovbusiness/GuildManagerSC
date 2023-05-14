FROM vault

EXPOSE 8000

COPY Infrastructure/Vault/docker-entrypoint-override.sh /usr/local/bin/docker-entrypoint-override.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-override.sh

COPY Infrastructure/ServiceAwait/wait_for_service.sh /usr/local/bin/wait_for_service.sh
RUN chmod +x /usr/local/bin/wait_for_service.sh

COPY Infrastructure/ServiceAwait/IsReadyServer.sh /usr/local/bin/IsReadyServer.sh
RUN chmod +x /usr/local/bin/IsReadyServer.sh

COPY Infrastructure/Vault/vault_init.sh /usr/local/bin/vault_init.sh
RUN chmod +x /usr/local/bin/vault_init.sh

ENTRYPOINT ["docker-entrypoint-override.sh"]
CMD ["server", "-dev"]