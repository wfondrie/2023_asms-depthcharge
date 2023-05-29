# Depthcharge Examples

These are the notebooks and analyses that accompany my ASMS poster.

Run these depthcharge example notebooks on Google Colab:

- [Predicting ion mobility from peptide sequence and charge state]()
- [Predicting peptide fragment ion intensities]()
- [Embedding mass spectra and peptides to build a search engine]()


## Project Organization

```
├── Makefile            <- Makefile with commands reproduce the figures.
├── README.md           <- Basic information about this project.
├── data                <- Data either from the original source or from Colab notebooks.
├── notebooks           <- Jupyter notebooks for making poster figures.
├── colab               <- Deep learning Jupyter notebooks run on Google Colab.
├── environment.yml     <- Specifies the dependencies to build a conda environment.
│                          Create the environment with `make env && conda activate ./envs`
├── pyproject.toml      <- Specifies Python configuration for our local Python package.
└── src                 <- Source code for the local Python package to use in this project.
    └── __init__.py     <- Makes src a Python module
```

This project is based on the [Talus Cookiecutter Data Science
Template](https://github.com/TalusBio/cookiecutter-data-science)
