# Script 02 — Lookup Data Loading

## What This Script Does
Script 02 loads all the lookup tables used throughout the HR dataset. These include departments, job titles, skill sets, rating scales, training types, and other basic reference categories. These values stay stable across every run.

## How It Works
The script:

- Inserts standardized values into each lookup table  
- Establishes consistent categories for employee assignments  
- Provides the “source-of-truth” values referenced by the generator script  



## Role in the Workflow
This script runs after the schema is created and before employee and activity generation. All downstream tables depend on these lookup values.

