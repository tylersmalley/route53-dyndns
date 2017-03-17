FROM anigeo/awscli:latest
ENTRYPOINT []
WORKDIR /

RUN apk add --update curl

ENV ROUTE53_UPDATE_FREQUENCY 10800
ADD run.sh /run.sh
CMD ["/run.sh"]
