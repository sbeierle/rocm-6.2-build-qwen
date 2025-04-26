#!/bin/bash

echo "🧹 ROCm Info Summary:"
rocminfo | grep -E "Name:|gfx"

echo
echo "🧹 ROCm-SMI GPU Overview:"
/opt/rocm/bin/rocm-smi || echo "rocm-smi not found!"

echo
echo "🧹 HIP Compiler Check:"
hipcc --version || echo "hipcc not installed!"

echo
echo "🧹 Environment Variables:"
echo "ROCM_HOME=$ROCM_HOME"
echo "HIP_PATH=$HIP_PATH"
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "PATH=$PATH"
echo "HSA_OVERRIDE_GFX_VERSION=$HSA_OVERRIDE_GFX_VERSION"

echo
echo "🧹 Torch CUDA Check:"
python3 -c "import torch; print('Torch CUDA available:', torch.cuda.is_available())"
