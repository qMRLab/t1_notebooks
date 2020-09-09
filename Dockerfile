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
        curl \
        wget \
        gfortran \
        cmake \
        bsdtar  \
        rsync \
        imagemagick \
        gnuplot-x11 \
        libopenblas-base \
        octave \
        liboctave-dev  \
        octave-info \
        octave-parallel \
        octave-struct \
        octave-io \
        octave-statistics \
        octave-optim \
        octave-image \
        python3-dev \
        ttf-dejavu && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd $HOME/work;\
    pip install octave_kernel \
                sos==0.19.8 \
                sos-r \
                sos-notebook==0.19.4 \
                sos-python==0.9.12.1 \
                sos-bash==0.12.3 \
                sos-matlab==0.9.12.1 \
                sos-ruby==0.9.15.0 \
                sos-sas==0.9.12.3 \
                sos-julia==0.9.12.1 \
                sos-javascript==0.9.12.2 \
                scipy \
                matplotlib \
                plotly==3.10.0 \
                dash \
                dash_core_components \
                dash_html_components \
                dash_dangerously_set_inner_html \
                dash-renderer \
                flask; \
    python -m sos_notebook.install;\
    git clone -b blog_afi https://github.com/jvelazquez-reyes/t1_notebooks.git;  \
    cd t1_notebooks;\
    git clone -b update_2.5.0 https://github.com/qMRLab/qMRLab.git;   \
    cd qMRLab; \
    git checkout b69168f02f0680471a0c5590114752c037c9b041; \
    cd ..; \
    chmod -R 777 $HOME/work/t1_notebooks; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

WORKDIR $HOME/work/t1_notebooks

USER $NB_UID
