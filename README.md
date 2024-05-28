# Simulation Code and Results for "A New Sparse-Learning Model for Maximum Gap Reduction of Composite Fuselage Assembly"

## Overview

This repository contains the simulation code and results for the paper titled "A New Sparse-Learning Model for Maximum Gap Reduction of Composite Fuselage Assembly". [DOI](https://www.tandfonline.com/doi/suppl/10.1080/00401706.2022.2050817?scroll=top)

## Requirements

The proposed algorithm in this paper requires the `fom` package. All codes have been tested in MATLAB R2020a.

## Simulation Files

The following MATLAB files are provided for reproducibility purposes. These scripts fix the seed of random number generation under different noise levels:

- **`SimulationMain1_1.m`** and **`SimulationMain1_2.m`**: These files correspond to CASE I and CASE II, respectively.
- **`SimulationMain2_1.m`** and **`SimulationMain2_2.m`**: These files correspond to CASE III and CASE IV, respectively.

## Results

The results of the simulations are saved in the following `.mat` files:

- `SimulationMain1_1R.mat`
- `SimulationMain1_2R.mat`
- `SimulationMain2_1R.mat`
- `SimulationMain2_2R.mat`

## Usage

1. Ensure that you have MATLAB R2020a installed.
2. Install the required `fom` package.
3. Run the simulation scripts (`SimulationMain1_1.m`, `SimulationMain1_2.m`, `SimulationMain2_1.m`, `SimulationMain2_2.m`) in MATLAB to reproduce the results.
4. Load the corresponding `.mat` files to view the results.

