FROM jupyter/base-notebook:8ccdfc1da8d5

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl\
        wget \
        gfortran \
        cmake \
        bsdtar \
        rsync \
        imagemagick \
        \
        gnuplot-x11 \
        libopenblas-base \
        \
        octave \
        liboctave-dev \
        octave-info \
        octave-parallel \
        octave-struct \
        octave-io\
        octave-statistics\
        octave-optim\
        octave-image\
        \
        python3-dev \
        ttf-dejavu && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd $HOME/work;\
    pip install octave_kernel==0.28.4 \
                sos==0.17.2 \
                sos-notebook==0.17.0 \
                scipy==1.1.0 \
                plotly==3.4.0 \
                dash==0.29.0 \
                dash_core_components==0.37.0 \
                dash_html_components==0.13.2 \
                dash_dangerously_set_inner_html==0.0.1 \
                dash-renderer==0.14.3 \
                flask==0.12.2;\

    python -m sos_notebook.install;\
    git clone --single-branch -b blog_vfa https://github.com/qMRLab/t1_notebooks.git;       \
    cd t1_notebooks;\
    git clone --single-branch -b blog_vfa https://github.com/neuropoly/qMRLab.git;\
    chmod -R 777 $HOME/work/t1_notebooks; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

WORKDIR $HOME/work/t1_notebooks

USER $NB_UID
