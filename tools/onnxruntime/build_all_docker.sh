#!/bin/bash
DATESTAMP=`date '+%Y%m%d'`
docker images > imagelist.txt

if [ `id -u` != 0 ]; then
    echo script should be run as root
    exit 0
fi

grep -q cpu-${DATESTAMP} imagelist.txt
result=$?
if [ $result != 0 ]; then
    ./build_cpu_docker.sh 2>&1 | tee build_cpu.txt
fi

grep -q cuda-${DATESTAMP} imagelist.txt
result=$?
if [ $result != 0 ]; then
    ./build_cuda_docker.sh 2>&1 | tee build_cuda.txt
fi

grep -q tensorrt-${DATESTAMP} imagelist.txt
result=$?
if [ $result != 0 ]; then
    ./build_tensorrt_docker.sh 2>&1 | tee build_tensorrt.txt
fi

grep -q openvino-${DATESTAMP} imagelist.txt
result=$?
if [ $result != 0 ]; then
    ./build_openvino_docker.sh 2>&1 | tee build_openvino.txt
fi

grep -q migraphx-rocm37-${DATESTAMP} imagelist.txt
result=$?
if [ $result != 0 ]; then
    cp miopen37/* onnxruntime/dockerfiles
    ./build_migraphx_docker.sh 2>&1 | tee build_migraphx.txt
fi
