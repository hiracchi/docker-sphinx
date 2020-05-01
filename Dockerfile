FROM hiracchi/texlive:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/hiracchi/docker-sphinx" \
  org.label-schema.version=$VERSION \
  maintainer="Toshiyuki Hirano <hiracchi@gmail.com>"


ARG WORKDIR="/work"
ENV LC_ALL=C LANG=C DEBIAN_FRONTEND=noninteractive

ENV PACKAGES="\
  make \
  python3 python3-pip \
  graphviz \
  libjs-mathjax \
  fonts-mathjax fonts-mathjax-extras \
  "

ENV PIP_PACKAGES="\
  sphinx sphinx-intl \
  commonmark recommonmark \
  sphinx-autorun sphinx-autobuild sphinx-paramlinks \
  blockdiag sphinxcontrib-blockdiag sphinxcontrib-nwdiag sphinxcontrib-seqdiag \
  sphinxcontrib-bibtex \
  sphinxcontrib-plantuml \
  sphinxcontrib-programoutput \
  sphinxcontrib-spelling \
  sphinx-theme sphinx-rtd-theme sphinx-bootstrap-theme \
  sphinx_fontawesome \
  sphinx-quickstart-plus \
  "

# -----------------------------------------------------------------------------
# packages
# -----------------------------------------------------------------------------
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  ${PACKAGES} \
  && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* 

# -----------------------------------------------------------------------------
# pip
# -----------------------------------------------------------------------------
RUN set -x && \
  pip3 install ${PIP_PACKAGES}

# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY scripts/* /usr/local/bin/

RUN set -x && \
  mkdir -p "${WORKDIR}"
WORKDIR "${WORKDIR}"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/local/bin/usage.sh"]
