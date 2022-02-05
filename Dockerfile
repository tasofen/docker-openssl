FROM alpine as base
RUN apk add wget g++ make tar perl linux-headers
RUN wget https://www.openssl.org/source/openssl-1.1.1m.tar.gz
RUN tar -xvf openssl-1.1.1m.tar.gz
RUN cd openssl-1.1.1m && ./config --prefix=/opt/openssl '-Wl,-rpath,$(LIBRPATH)'
RUN cd openssl-1.1.1m && make
RUN cd openssl-1.1.1m && make install

FROM alpine
COPY --from=base /opt/openssl /opt/openssl
RUN ln -s /opt/openssl/bin/openssl /bin/openssl
ENTRYPOINT ["openssl"]