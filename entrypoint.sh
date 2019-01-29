FROM jenkins:2.60.3
USER root
RUN apt-get update \
&& apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable" \
&& apt-get update \
&& apt-get install -y docker-ce sudo \
&& rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
[centos@ucp-node-1 jenkins]$
[centos@ucp-node-1 jenkins]$
[centos@ucp-node-1 jenkins]$
[centos@ucp-node-1 jenkins]$
[centos@ucp-node-1 jenkins]$ cat entrypoint.sh
openssl s_client -connect ${DTR_IP}:443 -showcerts \
</dev/null 2>/dev/null | openssl x509 -outform PEM | sudo tee \
/usr/local/share/ca-certificates/${DTR_IP}.crt
sudo update-ca-certificates

/bin/tini -- /usr/local/bin/jenkins.sh

