#!/bin/bash
# Create and activate Python venv for ROCm + Torch
python3.12 -m venv rocm_env
source rocm_env/bin/activate
pip install --upgrade pip
pip install "numpy<2.0.0"
pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.1
pip install transformers safetensors accelerate

export ROCM_HOME=/opt/rocm
export HIP_PATH=/opt/rocm
export PATH=$ROCM_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$ROCM_HOME/lib64:$LD_LIBRARY_PATH
export HSA_OVERRIDE_GFX_VERSION=11.0.0
