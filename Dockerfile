FROM jupyter/base-notebook:8ccdfc1da8d5

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential\
        emacs=47.0 \
        git=1:2.17.1-1ubuntu0.3 \
        inkscape=0.92.3-1 \
        jed=1:0.99.19-7 \
        libsm6=2:1.2.2-1 \
        libxext-dev=2:1.3.3-1 \
        libxrender1=1:0.9.10-1 \
        lmodern=2.004.5-3 \
        netcat=1.10-41.1 \
        unzip=6.0-21ubuntu1 \
        nano=2.9.3-2 \
        curl=7.58.0-2ubuntu3.5 \
        wget=1.19.4-1ubuntu2.1 \
        gfortran=4:7.3.0-3ubuntu2.1 \
        cmake=3.10.2-1ubuntu2 \
        bsdtar=3.2.2-3.1ubuntu0.1  \
        rsync=3.1.2-2.1ubuntu1 \
        imagemagick=8:6.9.7.4+dfsg-16ubuntu6.4 \
        gnuplot-x11=5.2.2+dfsg1-2ubuntu1 \
        libopenblas-base=0.2.20+ds-4 \
        octave=4.2.2-1ubuntu1 \
        liboctave-dev=4.2.2-1ubuntu1 \
        octave-info=4.2.2-1ubuntu1 \
        octave-parallel=3.1.1-3 \
        octave-struct=1.0.14-3 \
        octave-io=2.4.10-3 \
        octave-statistics=1.3.0-4 \
        octave-optim=1.5.2-4 \
        octave-image=2.6.2-5 \
        python3-dev>=3.6.5-3ubuntu1 \
        ttf-dejavu=2.37-1 && \
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
