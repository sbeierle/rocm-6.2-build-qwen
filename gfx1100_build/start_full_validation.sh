#!/bin/bash

# 🎯 ROCm Environment Aktivieren
source ~/rocm_env/bin/activate

# 📦 Environment Variablen setzen
export ROCM_HOME=/opt/rocm
export HIP_PATH=/opt/rocm
export PATH=$ROCM_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$ROCM_HOME/lib64:$LD_LIBRARY_PATH
export HSA_OVERRIDE_GFX_VERSION=11.0.0

# 📥 Check und Installiere ROCm Tools wenn fehlen
if ! command -v rocminfo &> /dev/null
then
    echo "Installing rocminfo..."
    sudo apt install -y rocminfo
fi

if [ ! -f /opt/rocm/bin/rocm-smi ]; then
    echo "Installing rocm-smi..."
    sudo apt install -y rocm-smi
fi

# 🔍 ROCm Infos checken
echo "Checking ROCm info..."
rocminfo | grep gfx
/opt/rocm/bin/rocm-smi

# 🛠️ HIP Hello World bauen
echo "Building HIP Hello World..."
cd ~/rocm-6.2-build-qwen/gfx1100_build/hip_hello_world
hipcc -o hip_hello_world hip_hello_world.cpp

# 🚀 HIP Hello World ausführen
echo "Running HIP Hello World..."
./hip_hello_world

# 🤖 Torch GPU Check
echo "Torch CUDA availability check:"
python3 -c "import torch; print('Torch GPU available:', torch.cuda.is_available())"

echo "✅ All steps finished!"
#do not forget to chmod this script chmod +x start_full_validation.sh
#./start_full_validation.sh
