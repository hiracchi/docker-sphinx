FROM ubuntu:18.04

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

# setup packages ===============================================================
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  sudo locales tzdata bash \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  echo "dash dash/sh boolean false" | debconf-set-selections && \
  dpkg-reconfigure dash && \
  locale-gen ja_JP.UTF-8 && \
  update-locale LANG=ja_JP.UTF-8 && \
  echo "${TZ}" > /etc/timezone && \
  mv /etc/localtime /etc/localtime.orig && \
  ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  mkdir -p /etc/sudoers.d/ && \
  echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ALL && \
  chmod u+s /usr/sbin/useradd && \
  chmod u+s /usr/sbin/groupadd

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  make \
  python3 python3-pip \
  texlive-full \
  xdvik-ja gv \
  dvipng \
  gv nkf gnuplot tgif gimp inkscape mimetex latexdiff latexmk \
  libjs-mathjax \
  fonts-mathjax fonts-mathjax-extras \
  && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* 

# dvipsk-ja
# texlive texlive-lang-japanese texlive-lang-cjk texlive-fonts-recommended texlive-fonts-extra
# texlive-science

# python3-sphinx
# sphinx-intl
# python3-sphinx-celery
# python3-sphinx-autorun
# python3-sphinx-paramlinks
# python3-sphinxcontrib.bibtex
# python3-sphinxcontrib.blockdiag
# python3-sphinxcontrib.nwdiag
# python3-sphinxcontrib.seqdiag
# python3-sphinxcontrib.plantuml
# python3-sphinxcontrib.programoutput
# python3-sphinxcontrib.spelling
# python3-sphinx-bootstrap-theme

# python3-sphinx-rtd-theme
RUN set -x && \
  pip3 install \
  sphinx sphinx-intl \
  sphinx-autorun sphinx-paramlinks sphinx_celery \
  sphinxcontrib-blockdiag sphinxcontrib-nwdiag sphinxcontrib-seqdiag \
  sphinxcontrib-plantuml sphinxcontrib-programoutput sphinxcontrib-spelling \
  sphinx_rtd_theme sphinx_bootstrap_theme

# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY docker-entrypoint.sh usage.sh /

WORKDIR "${WORKDIR}"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usage.sh"]
