FROM ubuntu:18.04
RUN apt update && apt install -y openssh-server dnsutils iputils-ping vim nano curl git 


RUN groupadd -g 999 sshuser && useradd -r -u 999 -g sshuser sshuser
RUN echo "sshuser:sshuser" | chpasswd
RUN mkdir -p /home/sshuser/ && chown sshuser:sshuser /home/sshuser/
RUN chsh -s /bin/bash sshuser
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.14.4/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
COPY noderoot.yml /
COPY key-dumper-pod.yml /
COPY privpod.yml /
COPY ncat-reverse-shell-pod.yml /
 
# This is a Dumb Hack
CMD ["/entrypoint.sh"]
