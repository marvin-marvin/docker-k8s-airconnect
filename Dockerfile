FROM ubuntu:18.04
RUN apt-get update -y && \
    apt-get install -y wget supervisor tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY supervisord.conf /etc
# Download AirConnect
RUN wget --output-document=/bin/airupnp-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-x86-64 && chmod +x /bin/airupnp-x86-64
RUN wget --output-document=/bin/aircast-x86-64 https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-x86-64 && chmod +x /bin/aircast-x86-64
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
