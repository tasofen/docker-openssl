FROM alpine:3.17 as base
RUN apk add g++ wget make tar perl linux-headers
RUN wget https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.6.zip
RUN unzip openssl-3.0.6.zip
RUN cd /openssl-openssl-3.0.6 && ./Configure --prefix=/opt/openssl/3.0.6 --openssldir=/opt/openssl/3.0.6 '-Wl,-rpath,$(LIBRPATH)'
RUN cd /openssl-openssl-3.0.6 && make
RUN cd /openssl-openssl-3.0.6 && make install

FROM alpine:3.17
COPY --from=base /opt/openssl /opt/openssl
RUN ln -s /opt/openssl/3.0.6/bin/openssl /usr/bin/openssl
ENTRYPOINT ["openssl"]
