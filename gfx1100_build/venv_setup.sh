#!/bin/bash
# Create and activate Python venv for ROCm + Torch
python3.12 -m venv rocm_env
source rocm_env/bin/activate
pip install --upgrade pip
pip install "numpy<2.0.0"
pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.1
pip install transformers safetensors accelerate
