ROCm 6.2 on RX 7900 XTX (gfx1100) – Full Working Setup
Tested on: Ubuntu 24.10 (Kernel 6.8.x)
 GPU: AMD Radeon RX 7900 XTX (gfx1100, Navi 31)
 Compiler: LLVM 18 (hipcc)
 Status: 🔥 Full device access confirmed, HIP custom project built and ran successfully

📋 Setup Highlights
/dev/kfd correctly linked to GPU


export HSA_OVERRIDE_GFX_VERSION=11.0.0 properly set


HIP compiler hipcc fully functional (LLVM 18)


Self-built HIP project using CMake: success


ROCm bitcode available at /opt/rocm/amdgcn/bitcode


torch.cuda.is_available() = ✅ (no CUDA needed!)



🛠️ Validation Tests


Test
Status
ROCm SMI Detection
✅ Passed
HIP Hello World Kernel
✅ Passed
torch inference (Qwen 7B)
✅ Passed
Device Permissions /dev/kfd
✅ Passed
CMake HIP Build Test
✅ Passed


🛠️ Known Issues & Solutions


Issue
Solution
rocminfo shows no GPU devices
Ensure /dev/kfd permission and group membership (video group)
HIP project fails at compile stage
Check export HSA_OVERRIDE_GFX_VERSION=11.0.0 is set correctly
Missing LLVM toolchain
Install llvm-18 and check hipcc points to /opt/rocm/llvm/bin/
Safetensors load errors (Torch)
Use latest pip versions: pip install --upgrade safetensors
Flash Attention / SDPA experimental notice
Ignore; ROCm 6.2 brings partial support for sdpa and fa2
Kernel versions mismatch in ROCm build
Build and run on Ubuntu 24.10 or newer; Kernel 6.8/6.11 OK

💬 Commentary
Building a fully working ROCm 6.2 stack on Ubuntu 24.10 with RX 7900 XTX is a high-skill task — requiring deep understanding of kernel modules, HIP setup, permission fixes, device linking, and modern LLVM chains.
This repository proves it's possible without workarounds, without downgrades, without NVIDIA — pure AMD power unleashed.
A strategic blueprint for research, AI inference, and building open hardware alternatives.


⚡ Recap
"I brought ROCm 6.2 alive on a Navi 31 GPU under Ubuntu 24.10 — with HIP, LLVM 18, working device permissions, self-built projects, no fallbacks.
 No hacks. No cheating. Just real engineering."
📂 Folder Structure Proposal

gfx1100_build/
├── rocm_7900xtx_setup.md	# Full validation & setup notes
├── screenshots/         	# ROCm info, HIP hello world, torch test
├── hip_hello_world/     	# Minimal working HIP project
├── venv_setup.sh        	# Python virtual environment script
└── environment_checklist.md # Commands to verify after build

📬 Maintainer & Contact
Maintainer: KI-Horscht
 GitHub: https://github.com/sbeierle
 Contact: kihorscht@gmail.com
