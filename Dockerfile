FROM alpine:3.16.2

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    maintainer="smizy" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/scikit-learn" \
    org.label-schema.url="https://github.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com/smizy/docker-scikit-learn"

ENV SCIKIT_LEARN_VERSION  $VERSION

RUN set -x \
    && apk update \
    && apk --no-cache add \
        ca-certificates \
        fontconfig \
        freetype \
        jupyter-notebook \
        py3-beautifulsoup4 \
        py3-cycler \
        py3-fastjsonschema \
        py3-fonttools \
        py3-kiwisolver \
        py3-matplotlib \
        py3-openpyxl \
        py3-pillow \
        py3-pip \
        py3-pyrsistent \
        py3-scikit-learn=1.1.0-r1 \
        su-exec \
        tini \
    && pip3 install seaborn \
    ## old .xls read/write 
    && pip3 install xlrd \
    ## jp font
    && wget https://moji.or.jp/wp-content/ipafont/IPAexfont/ipaexg00401.zip \
    && unzip ipaexg00401.zip \
    && mkdir -p \
        /home/jupyter/.fonts \
        /home/jupyter/.config/fontconfig \
    && mv ipaexg00401/ipaexg.ttf /home/jupyter/.fonts/ \
    && fc-cache -fv \
    && fc-match \
    ## user
    && adduser -D  -g '' -s /sbin/nologin -u 1000 docker \
    && adduser -D  -g '' -s /sbin/nologin jupyter \
    && addgroup jupyter docker \
    && chown -R jupyter:jupyter /home/jupyter \ 
    ## clean
    # && apk del \
    #     .builddeps \
    && find /usr/lib/python3.10 -name __pycache__ | xargs rm -r \
    && rm -rf \
        /root/.[acpw]* \
        ipaexg00401* \
    ## dir
    && mkdir -p /etc/jupyter 

WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/
# COPY fonts.conf  /home/jupyter/.config/fontconfig

EXPOSE 8888

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["jupyter", "notebook"]