docker run --device=/dev/dri --device=/dev/kfd --network=host --group-add=video -v /home/mev:/home/mev mevermeulen/ort:migraphx-rocm33-20200928 env EXPROVIDER=migraphx /home/mev/source/rocm-migraphx/scripts/run_ort_mev.sh
