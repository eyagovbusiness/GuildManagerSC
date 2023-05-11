FROM rabbitmq:3.11.11-management-alpine

COPY Infrastructure/RabbitMQ/docker-entrypoint-override.sh /usr/local/bin/docker-entrypoint-override.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-override.sh

COPY Infrastructure/ServiceAwait/wait_for_service.sh /usr/local/bin/wait_for_service.sh
RUN chmod +x /usr/local/bin/wait_for_service.sh

COPY ./Infrastructure/RabbitMQ/rabbitmq_init.sh /usr/local/bin/rabbitmq_init.sh
RUN chmod +x /usr/local/bin/rabbitmq_init.sh

COPY ./Infrastructure/RabbitMQ/rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY ./Infrastructure/RabbitMQ/definitions.json /etc/rabbitmq/definitions.json
RUN rm -f /etc/rabbitmq/enabled_plugins
COPY ./Infrastructure/RabbitMQ/enabled_plugins /etc/rabbitmq/enabled_plugins

ENTRYPOINT ["docker-entrypoint-override.sh"]
EXPOSE 4369 5671 5672 15691 15692 25672
CMD ["rabbitmq-server"]



