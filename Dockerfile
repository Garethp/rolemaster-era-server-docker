FROM bitnami/minideb

WORKDIR /usr/src/app

COPY entrypoint.sh .

CMD ["sh", "entrypoint.sh"]
