#!/usr/bin/env bash

# Exit immediately on errors, treat unset variables as an error, and fail on error in any pipeline
set -euo pipefail

# Customizing the PS4 variable to show expanded variables
export PS4='+ \e[36m${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }$ \e[m'

# Enable debugging if the last argument is --verbose
if [[ "${@: -1}" == "--verbose" ]]; then
  set -x
  set -- "${@:1:$(($#-1))}"  # Remove the last argument (--verbose)
fi


# Initialize and update git submodules
if [ -d .git ]; then
  git submodule init
  git submodule update
fi


# Define the directory for local Miniconda installation
MINICONDA_DIR=".deploy/miniconda"

# Clean up any previous Conda environment and build targets
rm -rf .deploy/conda_environment/
rm -rf $MINICONDA_DIR

# Install Miniconda locally
curl -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_24.5.0-0-Linux-x86_64.sh
bash /tmp/miniconda.sh -b -p $MINICONDA_DIR
rm /tmp/miniconda.sh

# Initialize conda in the current shell (without modifying any shell configuration files)
eval "$(.deploy/miniconda/bin/conda shell.bash hook)"




# Activate the base Conda environment
conda activate base

# Clean up any previous Conda environment and build targets
rm -rf .deploy/conda_environment/

# Create and activate a new Conda environment based on .deploy/conda.yaml configuration
conda env create --prefix .deploy/conda_environment/ --file .deploy/conda.yaml
conda activate .deploy/conda_environment/

# Install Python dependencies from the requirements file
pip install --requirement .deploy/pip.txt

# conda env config vars list
# conda env update --file .deploy/conda.yaml --prune
