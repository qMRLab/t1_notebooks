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
        bsdtar \
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
    pip install --upgrade pip; \
    pip install --upgrade setuptools; \
    pip install Cython>=0.29.28; \
    pip install pyarrow>=0.4.0; \
    pip install octave_kernel \
                sos==0.17.7 \
                sos-r \
                sos-notebook==0.17.2 \
                sos-python==0.9.12.1 \
                sos-bash==0.12.3 \
                sos-matlab==0.9.12.1 \
                sos-ruby==0.9.15.0 \
                sos-sas==0.9.12.3 \
                sos-julia==0.9.12.1  \
                sos-javascript==0.9.12.2  \
                sos-r==0.9.12.2 \
                scipy \
                plotly \
		nibabel \
                flask; \
    python -m sos_notebook.install; \
    git clone --single-branch -b blog_mtr https://github.com/qMRLab/t1_notebooks.git;            \
    cd t1_notebooks;\
    git clone https://github.com/neuropoly/qMRLab.git;     \
    cd qMRLab; \
    git checkout mb/qmt_ismrm; \
    cd ..; \
    chmod -R 777 $HOME/work/t1_notebooks; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

WORKDIR $HOME/work/t1_notebooks

USER $NB_UID
