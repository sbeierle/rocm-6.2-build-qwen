🔧 ROCm 6.1 Qwen7B Setup (AMD RX 7900 | Torch | Safetensors)
✅ Fully working ROCm + Torch + Safetensors Setup for Qwen 7B Inference
🧠 Research focus: Ethical LLM Reverse Engineering & Red Teaming
⚙️ GPU: AMD Radeon RX 7900 XTX | ROCm 6.1 | Python 3.10 / 3.12 | Linux Kernel 6.8 / 6.11 (Ubuntu 22.04 & 24.10)
________________


📦 Project Description
This repository documents a stable AMD ROCm 6.1 environment for local inference with Qwen 7B.
It's part of a research initiative in ethical LLM deconstruction, safetensors inspection, and reverse engineering.
Features:
* ROCm 6.1 installation (APT-based, with working HIP + Torch)

* Python 3.10 (Ubuntu 22.04) and 3.12 (Ubuntu 24.10) tested

* Inference with safetensors (.safetensors format)

* Full venv + bash scripting setup

* Derestriction workflow used internally (Qwen 7B only)

________________


🚀 Quickstart
git clone https://github.com/sbeierle/rocm-6.1-stable-amd-qwen7b.git
cd rocm-6.1-stable-amd-qwen7b
bash scripts/start_qwen_env.sh


System Requirements:
   * Ubuntu 22.04 or 24.10

   * Python 3.10 / 3.12

   * ROCm-compatible AMD GPU (gfx1100+, e.g. RX 7900 XTX)

   * At least 64 GB RAM and ~40 GB disk for Qwen 7B

________________


🪡 Project Phases (Qwen 7B)
Phase
	Step
	0
	ROCm 6.1 Install & Python Environment
	1
	Inference test with safetensors + validation
	2
	Backup creation after major changes
	3
	Trigger prompt tests (watchdog & prompt_critical_tester)
	4
	Patch critical token norms (details private)
	Automated snapshot after each successful step:
tar -czf ~/snapshots/qwen7b_phase$(date +%Y%m%d_%H%M).tar.gz ~/models/Qwen2.5-7B-Instruct


________________


🔍 Installation Steps (Ubuntu 24.10)
1. Add AMD ROCm Repo
wget https://repo.radeon.com/amdgpu-install/6.1.0/ubuntu/jammy/amdgpu-install_6.1.60100-1_all.deb
sudo apt install ./amdgpu-install_6.1.60100-1_all.deb
sudo amdgpu-install --usecase=rocm --no-dkms


2. Install Dependencies
sudo apt install git wget build-essential python3.12 python3.12-venv


3. Python & Torch Setup
python3.12 -m venv rocm_env
source rocm_env/bin/activate
pip install --upgrade pip
pip install "numpy<2.0.0"  # For older Ubuntu compatibility
pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.1
pip install transformers safetensors accelerate


4. Set ROCm Environment Variables
export ROCM_HOME=/opt/rocm
export HIP_PATH=/opt/rocm
export PATH=$ROCM_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$LD_LIBRARY_PATH
export HSA_OVERRIDE_GFX_VERSION=11.0.0


________________


🧪 Testing
rocminfo | grep gfx
/opt/rocm/bin/rocm-smi
python -c "import torch; print(torch.cuda.is_available())"


Expected Output:
GPU erkannt: True
Gerät: AMD Radeon RX 7900 XTX


________________


🧠 Example Inference (Qwen 7B)
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch
model = AutoModelForCausalLM.from_pretrained("./models/Qwen2.5-7B-Instruct", torch_dtype=torch.float16, device_map="auto")
tokenizer = AutoTokenizer.from_pretrained("./models/Qwen2.5-7B-Instruct")
inputs = tokenizer("Was ist die Hauptstadt von Peru?", return_tensors="pt").to("cuda")
outputs = model.generate(**inputs, max_new_tokens=64)
print(tokenizer.decode(outputs[0], skip_special_tokens=True))


________________


📂 Included Tools
Tool
	Description
	scripts/start_qwen_env.sh
	Activates venv & sets ROCm exports
	vector5_patcher.py
	Patch token vectors manually
	prompt_critical_tester_v6.py
	Run prompt tests incl. softfilter scan
	tensor_locator.py
	Locate tensors per shard
	.gitignore
	Filters out large files
	________________


📌 Notes
      * Patched model used only for academic testing (Qwen 7B)

      * 32B project is not public yet – under private validation

      * Patch critical token norms (details private)

      * Backups after each test phase

      * Full setup built & validated without CUDA (ROCm only)

      * Compatible with Python 3.10 & 3.12

________________


⚠️ Legal / Access
All content provided for educational & scientific research.
No binaries or derestriction scripts are included publicly.
Authorized institutions or research organizations may request access to the fully patched LLM 7B without restrictions and to critical_prompts.
📬 Kontakt: kihorscht@gmail.com
________________


Maintainer: KI-Horscht
 GitHub: https://github.com/Ki-Horscht