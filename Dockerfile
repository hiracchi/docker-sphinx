FROM hiracchi/ubuntu-ja:18.04

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hiracchi/docker-sphinx" \
      org.label-schema.version=$VERSION \
      maintainer="Toshiyuki Hirano <hiracchi@gmail.com>"


ARG WORKDIR="/work"

# setup packages ===============================================================
# python3
RUN set -x \
  && apt-get update \
  && apt-get install -y \
     make \
     python3 python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# LaTeX
RUN set -x \
  && apt-get update \
  && apt-get install -y \
     texlive-full \
     xdvik-ja gv \
     dvipng \
     gv nkf gnuplot tgif gimp inkscape mimetex latexdiff latexmk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
# dvipsk-ja
# texlive texlive-lang-japanese texlive-lang-cjk texlive-fonts-recommended texlive-fonts-extra
# texlive-science

# sphinx
RUN set -x \
  && apt-get update \
  && apt-get install -y \
     libjs-mathjax \
     fonts-mathjax fonts-mathjax-extras \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
#     python3-sphinx
#     sphinx-intl
#     python3-sphinx-celery
#     python3-sphinx-autorun
#     python3-sphinx-paramlinks
#     python3-sphinxcontrib.bibtex
#     python3-sphinxcontrib.blockdiag
#     python3-sphinxcontrib.nwdiag
#     python3-sphinxcontrib.seqdiag
#     python3-sphinxcontrib.plantuml
#     python3-sphinxcontrib.programoutput
#     python3-sphinxcontrib.spelling
#     python3-sphinx-bootstrap-theme


# python3-sphinx-rtd-theme
RUN set -x \
    && pip3 install \
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
