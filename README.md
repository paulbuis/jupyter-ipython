[![docker pulls](https://img.shields.io/docker/pulls/jupyter/minimal-notebook.svg)](https://hub.docker.com/r/jupyter/minimal-notebook/) [![image metadata](https://images.microbadger.com/badges/image/jupyter/scipy-notebook.svg)](https://microbadger.com/images/jupyter/scipy-notebook "jupyter/scipy-notebook image metadata")

# Dockerfile based on Jupyter Notebook Scientific Python Stack

This builds an Docker image similar to the Jupyter Docker Stack named "jupyter/scipy-notebook"
from github.com/jupyter/dockerstacks.
It is also based on the jupyter/minimal-notebook found at 
https://hub.docker.com/r/juptyer/minimal-notebook/.
It includes a larger set of conda packages than jupyter/scipi-notebook.

Unlike github.com/paulbuis/jupyter-beakerx, it does not include any language kernals other than IPython.

# Aditional Anaconda-Forge Items, not in jupyter/scipy-notebook
- pygraphviz=11.5

See also:
* [Jupyter Docker Stacks on ReadTheDocs](http://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
* [Selecting an Image :: Core Stacks :: jupyter/minimal-notebook](http://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-minimal-notebook)
