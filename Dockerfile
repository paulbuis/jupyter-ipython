# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=paulbuis/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Paul Buis <00pebuis@bsu.edu>"

USER root

# ffmpeg for matplotlib anim
RUN apt-get update && \
    apt-get dist-upgrade -yq && \
    apt-get install -y --no-install-recommends \
	ffmpeg \
	libicu-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install Python 3 packages
# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
RUN conda install --quiet --yes \
    'conda-forge::blas=*=openblas' \
    'ipywidgets=7.4*' \
    'pandas=0.24*' \
    'numexpr=2.6*' \
    'matplotlib=3.0*' \
    'scipy=1.2*' \
    'seaborn=0.9*' \
    'scikit-learn=0.20*' \
    'scikit-image=0.14*' \
    'sympy=1.3*' \
    'cython=0.29*' \
    'patsy=0.5*' \
    'statsmodels=0.9*' \
    'cloudpickle=0.8*' \
    'dill=0.2*' \
    'dask=1.1.*' \
    'numba=0.42*' \
    'bokeh=1.0*' \
    'sqlalchemy=1.3*' \
    'hdf5=1.10*' \
    'h5py=2.9*' \
    'vincent=0.4.*' \
    'beautifulsoup4=4.7.*' \
    'protobuf=3.7.*' \
    'xlrd'  \
    'pygraphviz=1.5' \
    'nodejs=11.14.*' \
    'pyyaml' \
    'jupyter_contrib_nbextensions=0.5.1' \
    'jupyter_nbextensions_configurator=0.4.1' \
    'ipyleaflet=0.10.2' \
    conda remove --quiet --yes --force qt pyqt && \
    conda clean --all -f -y
#
# Already included ???
# nbconvert
# See also, https://github.com/mauhai/awesome-juptyerlab

# Activate ipywidgets extension in the environment that runs the notebook server
# Also activate ipywidgets extension for JupyterLab
# Check this URL for most recent compatibilities
# https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager

USER $NB_UID
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^0.38.1 &&\
    jupyter labextension install jupyterlab_bokeh@0.6.3 && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install facets which does not have a pip or conda package at the moment
#RUN cd /tmp && \
#    git clone https://github.com/PAIR-code/facets.git && \
#    cd facets && \
#    jupyter nbextension install facets-dist/ --sys-prefix && \
#    cd && \
#    rm -rf /tmp/facets && \
#    fix-permissions $CONDA_DIR && \
#    fix-permissions /home/$NB_USER

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

USER $NB_UID
