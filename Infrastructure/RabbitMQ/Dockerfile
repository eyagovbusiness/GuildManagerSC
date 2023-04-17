FROM rabbitmq:3.11.11-management-alpine

COPY ./Infrastructure/RabbitMQ/rabbitmq_init.sh /etc/rabbitmq/rabbitmq_init.sh
COPY ./Infrastructure/RabbitMQ/rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY ./Infrastructure/RabbitMQ/definitions.json /etc/rabbitmq/definitions.json
RUN rm -f /etc/rabbitmq/enabled_plugins
COPY ./Infrastructure/RabbitMQ/enabled_plugins /etc/rabbitmq/enabled_plugins

RUN chmod +x /etc/rabbitmq/rabbitmq_init.sh
CMD /bin/bash /etc/rabbitmq/rabbitmq_init.sh


