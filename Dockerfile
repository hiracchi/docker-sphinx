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
  python3 python3-pip \
  libjs-mathjax \
  fonts-mathjax fonts-mathjax-extras \
  python3-sphinx \
  sphinx-intl \
  python3-sphinx-celery \
  python3-sphinx-autorun \
  python3-sphinx-paramlinks \
  python3-sphinxcontrib.bibtex \
  python3-sphinxcontrib.blockdiag \
  python3-sphinxcontrib.nwdiag \
  python3-sphinxcontrib.seqdiag \
  python3-sphinxcontrib.plantuml \
  python3-sphinxcontrib.programoutput \
  python3-sphinxcontrib.spelling \
  python3-sphinx-bootstrap-theme \
  python3-sphinx-rtd-theme \
  "

# setup packages ===============================================================
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  ${PACKAGES} \
  && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* 

# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY scripts/* /usr/local/bin/

RUN set -x && \
  mkdir -p "${WORKDIR}"
WORKDIR "${WORKDIR}"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/local/bin/usage.sh"]
