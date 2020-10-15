FROM smizy/python:3.8.2-alpine

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
        fontconfig \
        freetype \
        openblas \
        py3-argon2-cffi \
        py3-dateutil \
        py3-decorator \
        py3-defusedxml \
        py3-jinja2 \
        py3-jsonschema \
        py3-markupsafe \
        py3-pexpect \
        py3-prometheus-client \
        py3-prompt_toolkit \
        py3-pygments \
        py3-ptyprocess \
        py3-six \
        py3-tornado \
        py3-wcwidth \
        py3-pyzmq \
        tini \
    && pip3 install --upgrade pip setuptools wheel \
    # PyZMQ with tornado 6.0 raises the wrong warning. #1310
    # https://github.com/zeromq/pyzmq/issues/1310
    # > This was fixed in 17.1.3 by #1263 and does not affect pyzmq 18 or master.
    # && pip3 install 'tornado>=5.0,<6.0' \
    && pip3 install ipython \
    && pip3 install notebook \
    && pip3 install ipywidgets \
    && pip3 install jupyter-console \
    ## numpy 
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && apk --no-cache add --virtual .builddeps \
        build-base \
        freetype-dev \
        gfortran \
        openblas-dev \
        pkgconf \
        python3-dev \
        wget \
    ## dependency for pandas 
    && apk --no-cache add  \
        py3-tz \
    ## pandas
    # - BUG: error: may be used uninitialized. In alpine #35622
    #   https://github.com/pandas-dev/pandas/issues/35622
    #   will be fixed on 1.2 release
    ## scipy
    # - Missing `int64_t` declaration in rectangular_lsap.cpp #11319
    #   https://github.com/scipy/scipy/issues/11319
    && pip3 install \
        Cython \
        numpy \
        'pandas<1.1' \
        'scipy<1.4' \
    ## scikit-learn 
    ## --no-use-pep517: pyproject.toml cause to build  (ignoring requirement matched dependency)
    && pip3 install --no-use-pep517 scikit-learn==${SCIKIT_LEARN_VERSION} \
    ## seaborn/matplotlib
    && pip3 install seaborn \
    ## excel read/write 
    && pip3 install xlrd openpyxl \
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
    && adduser -D  -g '' -s /sbin/nologin jupyter \
    && addgroup jupyter docker \
    && chown -R jupyter:jupyter /home/jupyter \ 
    ## clean
    && apk del \
        .builddeps \
    && find /usr/lib/python3.8 -name __pycache__ | xargs rm -r \
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