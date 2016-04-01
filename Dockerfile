FROM d3v0x/gentoo

RUN emerge-webrsync -v
RUN echo "MAKEOPTS=\"-j$(cat /proc/cpuinfo | grep processor | wc -l)\"" >> /etc/portage/make.conf

RUN emerge www-servers/nginx
RUN rm -rf /usr/portage

EXPOSE 80 443

CMD nginx
