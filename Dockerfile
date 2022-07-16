FROM alpine as base
RUN apk add g++ wget make tar perl linux-headers
RUN wget https://www.openssl.org/source/openssl-3.0.4.tar.gz
RUN tar -xvf openssl-3.0.4.tar.gz
RUN cd /openssl-3.0.4 && ./Configure --prefix=/opt/openssl/3.0.4 --openssldir=/opt/openssl/3.0.4 '-Wl,-rpath,$(LIBRPATH)'
RUN cd /openssl-3.0.4 && make
RUN cd /openssl-3.0.4 && make install

FROM alpine
COPY --from=base /opt/openssl /opt/openssl
RUN ln -s /opt/openssl/3.0.4/bin/openssl /usr/bin/openssl
ENTRYPOINT ["openssl"]
