FROM ubuntu:24.04

RUN apt -y update && apt -y install curl

RUN mkdir -p /opt/dev-tools 

WORKDIR /opt/dev-tools

COPY . .

RUN chmod +x ./main.sh

ENV SUDO=""

ENTRYPOINT ["./main.sh"]
CMD ["tail -f /dev/nul"]
