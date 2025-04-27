
  # Important: Gfx1100 Build Folder
  
  The `gfx1100_build/` folder is an essential part of this project.
  It contains a full ROCm 6.2 validation and setup blueprint specifically for AMD RX 7900 XTX GPUs (gfx1100 architecture).
  
  - Minimal HIP tests
  - ROCm device verification
  - Full Python venv setup for Torch
  - Step-by-step screenshots for confirmation
  
  👉 If you want to **fully validate or replicate** this build, make sure to follow the instructions inside `gfx1100_build/`!






## 🎯 Project Mission – ROCm as Ethical LLM Backbone

This repository is part of a broader research initiative that aims to **demonstrate the viability of a fully working AMD ROCm-based inference environment** for powerful LLMs like Qwen 7B – running on standard high-end desktop hardware (e.g., RX 7900 XTX).  

It serves as a **proof-of-concept** that:

- 🧠 **Research-grade LLM setups can be built without CUDA or Nvidia hardware**
- 💸 Powerful AI development is possible **on cost-efficient systems**, ideal for universities, security institutions, and **underfunded regions**
- 🧰 Full ROCm 6.2 setup supports **safetensors, transformers, WebGPU, Python 3.12**, and aggressive inference workflows

---

## 🌍 Strategic Goals

- ✅ Create a transparent, reproducible ROCm LLM stack as an **open alternative to NVIDIA’s closed CUDA ecosystem**
- 🛡️ Highlight the **importance of open infrastructure** in future AI sovereignty and digital security
- 🏫 Provide a starting point for **academic institutions in developing nations** to explore LLM inference and bias removal
- 🧪 Offer the **building blocks for scalable Red Team & bias testing** using native ROCm environments
- 🔬 Act as a launchpad for **larger models (32B/72B)** to investigate:
  - Whether LoRA training is still required when raw data & softfiltering are already fully patched
  - How modular multi-LLM setups (with derestricted agents) can outperform monolithic models

---

## 💡 Extended Research Context

This repo is part of a **larger Multi-LLM project**, designed to:

- Combine strengths of **derestricted open-source models**
- Run coordinated pipelines across multiple LLMs (e.g., Qwen, DeepSeek, etc.)
- Enable algorithmic chaining, vector routing and **GPT-API fusion**
- Prepare infrastructure for **AI safety, cyber defense, and real-time Red Teaming**

### 🌐 Additional Infrastructure Tested:

- ✅ FAISS-based vector memory (for exploit-related datasets)
- ✅ LoRA prototypes trained on domain-specific exploit samples
- ✅ Obfuscated VPN-based WebScraping for data gathering
- ✅ Partial Flax-based inference on remote GPU servers
- ✅ Pre-validation of performance vs. **H100 architecture**:  
  > Local ROCm GPU systems are viable, but for multi-agent LLM orchestration or fine-tuning, **a GPU cluster (e.g., H100)** is highly recommended due to the **extreme time gain**.

---

## 🧬 A Foundation for the 32B & 72B Era

This project lays the **operational groundwork** for:
- Full-scale derestricted 32B & 72B setups
- Cross-LLM alignment experiments
- Prompt-trigger research
- Quantum-safe LLM architecture planning

> In an age where every nation is building its own sovereign LLM stack, these tools will become essential not just for AI, but for digital independence itself.

---

### 📬 Contact for Collaboration or Institutional Access:

> ✉️ [kihorscht@gmail.com](mailto:kihorscht@gmail.com)




﻿🔧 ROCm 6.1 Qwen7B Setup (AMD RX 7900 | Torch | Safetensors)
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
