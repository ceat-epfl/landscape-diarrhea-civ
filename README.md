[![CC BY 4.0][cc-by-shield]][cc-by]

# Urban landscapes and diarrhoea in Côte d'Ivoire

## Terms of use

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-green.svg

## About

A replicable computational workflow to assess the association between urban landscape metrics and the prevalence of diarrhoea, striclty based on open-access data.

**Citation:** Pessoa Colombo V, Chenal J, Koné B, Bosch M, Utzinger J. Using Open-Access Data to Explore Relations between Urban Landscapes and Diarrhoeal Diseases in Côte d’Ivoire. *International Journal of Environmental Research and Public Health*. 2022; 19(13):7677. https://doi.org/10.3390/ijerph19137677

## Instructions to reproduce the analysis

### 1. Install conda

https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html

### 2. Create and activate environment

From the repository root, run:

```bash
conda env create -f environment.yml
conda activate LS_metrics
```

### 3. Download input data

Note that access to DHS data must be requested separately, on this site:

https://dhsprogram.com/data/dataset/Cote-d-Ivoire_Standard-DHS_2012.cfm?flag=0

The rest of the data can be automatically downloaded, by running:

```bash
make download_data
```

### 4. Run the notebooks

Follow the order indicated in the names of the notebooks: 0-1-2-3 (see prefix).
