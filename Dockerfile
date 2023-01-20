FROM alpine:3.17 as base
RUN apk add wget g++ make tar perl linux-headers
RUN wget https://www.openssl.org/source/openssl-1.1.1s.tar.gz
RUN tar -xvf openssl-1.1.1s.tar.gz
RUN cd openssl-1.1.1s && ./config --prefix=/opt/openssl '-Wl,-rpath,$(LIBRPATH)'
RUN cd openssl-1.1.1s && make
RUN cd openssl-1.1.1s && make install

FROM alpine:3.17
COPY --from=base /opt/openssl /opt/openssl
RUN ln -s /opt/openssl/bin/openssl /bin/openssl
ENTRYPOINT ["openssl"]