#!/usr/bin/bash

set -e

models=(
    Baichuan2-7B-Chat-OV
    chatglm3-6b-OV
    glm-4-9b-chat-OV
    Meta-Llama-3-8B-OV
    Qwen2-7B-OV
)
# for model in ${models[@]} ; do echo $model ; done

# ll /dev/dri/by-path/ to list gpus
gpus=(
    0
    1
)

export results='results.log'
echo -e "\n\n$(date)" >> $results
# date >> $results

# set -x
echo "${#models[@]} models"

same_gpu () {
# do testing on the same gpu continously, tempareture problem?
for model in ${models[@]} ; do 
    export modelov=$model
    echo $model | tee -a $results
    for gpu in {0,1} ; do 
        bash my.sh $gpu 32 32
        bash my.sh $gpu 1024 128
        bash my.sh $gpu 1024 1024
        bash my.sh $gpu 2048 1024
    done
    #bash my.sh 1 32 32
    #bash my.sh 1 1024 128
    #bash my.sh 0 1024 1024
    #bash my.sh 0 2048 1024
done
}

echo_yellow () {
    echo -e "\033[1;33m${1}\033[0m"
}

i=0
for model in ${models[@]} ; do 
    echo -e "\n$model\n" | tee -a $results
    #echo "model $((++i))/${#models[@]}"
    echo_yellow "model $((++i))/${#models[@]}"
    export modelov=$model
    for pair in '32:32' '1024:128' '1024:1024' '2048:1024' ; do
        in=${pair%:*}
        out=${pair#*:}
        for gpu in ${gpus[@]} ; do 
            echo "GPU.$gpu in=$in out=$out" | tee -a $results
            bash do_benchmark.sh $gpu $in $out
        done
    done
done
