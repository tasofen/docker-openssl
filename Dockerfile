FROM alpine as base
RUN apk add g++ wget make tar perl linux-headers
RUN wget https://www.openssl.org/source/openssl-3.0.5.tar.gz
RUN tar -xvf openssl-3.0.5.tar.gz
RUN cd /openssl-3.0.5 && ./Configure --prefix=/opt/openssl/3.0.5 --openssldir=/opt/openssl/3.0.5 '-Wl,-rpath,$(LIBRPATH)'
RUN cd /openssl-3.0.5 && make
RUN cd /openssl-3.0.5 && make install

FROM alpine
COPY --from=base /opt/openssl /opt/openssl
RUN ln -s /opt/openssl/3.0.5/bin/openssl /usr/bin/openssl
ENTRYPOINT ["openssl"]
