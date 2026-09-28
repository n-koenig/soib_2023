#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=ebird-soib
#SBATCH --output=/home/nilsko/Projects/soib_2023/ebird-soib-%j.out
#SBATCH --error=/home/nilsko/Projects/soib_2023/ebird-soib-%j.err
#SBATCH --cpus-per-task=50
#SBATCH --ntasks=1

srun Rscript --vanilla --no-save --no-restore /home/nilsko/Projects/soib_2023/submit.R
