# SoftEther VPN server

FROM debian:8
MAINTAINER Frank Rosquin <frank.rosquin@gmail.com>

#ENV VERSION v4.18-9570-rtm-2015.07.26
ENV VERSION v4.21-9613-beta-2016.04.24
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/local/vpnserver

RUN apt-get update &&\
        apt-get dist-upgrade -y && \
        apt-get -y -q install gcc make wget iptables && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnserver.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make wget

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

ENTRYPOINT ["/usr/local/vpnserver/runner.sh"]
