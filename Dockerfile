FROM ubuntu:18.04
RUN apt update && apt install -y openssh-server


RUN groupadd -g 999 sshuser && useradd -r -u 999 -g sshuser sshuser
RUN echo "sshuser:sshuser" | chpasswd
RUN mkdir -p /home/sshuser/
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

# This is a Dumb Hack
CMD ["/entrypoint.sh"]
