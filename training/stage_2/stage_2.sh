#!/bin/bash

ENTITY="ahjwang" # replace with your wandb entity
LOG_GROUP="emma_s2" # group to log runs in wandb
SLURM_ARGS="-A pnlp" # replace with your slurm args

CMD="python ../train.py --stage 2 --lr 0.00005 --update_timestep 64 --optimizer Adam --weight_decay 0.0 --max_time 47.75 --max_steps 64 --gamma 0.99 --freeze_attention --entity $ENTITY --log_group $LOG_GROUP"

mkdir -p output
mkdir -p slurm
for seed in 1 2 3;
do
    sbatch $SLURM_ARGS stage_2.slurm $CMD --seed $seed --output output/emma_s2_$seed --load_state ../stage_1/output/emma_s1_"$seed"_max.pth
done