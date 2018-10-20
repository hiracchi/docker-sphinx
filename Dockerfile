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
RUN set -x \
  && apt-get update \
  && apt-get install -y \
     make \
     python3-sphinx \
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
     python3-sphinx-celery \
     python3-sphinx-rtd-theme \
     libjs-mathjax \
     fonts-mathjax fonts-mathjax-extras \
     texlive texlive-lang-japanese texlive-lang-cjk texlive-fonts-recommended texlive-fonts-extra \
     xdvik-ja gv \
     gv nkf gnuplot tgif gimp inkscape mimetex latexdiff latexmk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

#     dvipsk-ja \


# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY docker-entrypoint.sh usage.sh /

WORKDIR "${WORKDIR}"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usage.sh"]
