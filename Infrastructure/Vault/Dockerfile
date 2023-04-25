FROM vault

COPY Infrastructure/Vault/docker-entrypoint-override.sh /usr/local/bin/docker-entrypoint-override.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-override.sh

COPY Infrastructure/Vault/vault_init.sh /usr/local/bin/vault_init.sh
RUN chmod +x /usr/local/bin/vault_init.sh

ENTRYPOINT ["docker-entrypoint-override.sh"]
CMD ["server", "-dev"]