#!/usr/bin/bash
# x.sh gpu.0 in out
# set -x
set -e

if [ $# -ne 3 ]; then
    echo "$0 GPU.0 in=1024 out=128"
    echo "$0 0 1024 128"
else
    gpu=$1
    in=$2
    out=$3
    # python benchmark.py -d GPU.0 -m ~/models/${modelov}/pytorch/dldt/compressed_weights/OV_FP16-INT4_SYM -n 1 -bs 1 -pf ~/models/prompts/prompt1024.jsonl -ic 128
    python benchmark.py -d GPU.${gpu} -m ~/models/${modelov}/pytorch/dldt/compressed_weights/OV_FP16-INT4_SYM -n 1 -bs 1 -pf ~/models/prompts/prompt${in}.jsonl -ic ${out} | grep "Average" | tee -a $results
fi

