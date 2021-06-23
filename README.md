[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5017099.svg)](https://doi.org/10.5281/zenodo.5017099)

# General

The skeleton of this thesis manuscript was greatly inspired by the ones of Clément Mommessin and Millian Poquet, which in turn are inspired by Raphaël Bleuse, David Beniamine and David Glesser.

The makefile provides convenient recipes to build the whole thesis or unique chapters, to check for missing refs, unreferenced labels or uncited references.
Feel free to hack the template however you like.

To build your own thesis you can use the provided Nix environment, the provided [Dockerfile](Dockerfile), or do it by
yourself with:
  - `(GNU)make` (for the Makefile)
  - `texlive` (the full one is provided by Nix, just to be safe)

# Data & Figures

All the figures used in the thesis manuscript or the slides are in the [img](img) directory. They have all been
generated using data available in the [data](data) directory. The code to generate these figures as well as some
provenance information are available in either the [figures.org](figures.org) notebook, or one of the notebooks in the
[figures_ipynb](figures_ipynb) directory.

# Continuous Integration

Using GitHub actions (see the [.github](.github) directory), both the thesis and the slides are compiled automatically
whenever a new commit is pushed. The build is done with a [Docker image](https://hub.docker.com/r/ezibenroc/orgmode_latex)
constructed with the provided [Dockerfile](Dockerfile).

The resulting PDF as well as some plots with basic statistics are deployed on GitHub pages (see the gh-pages branch).
