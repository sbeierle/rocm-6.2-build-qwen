# ROCm 6.2 on RX 7900 XTX (gfx1100) — Full Setup & Validation

This folder documents the successful installation, configuration, and validation of ROCm 6.2 on an AMD Radeon RX 7900 XTX (gfx1100) GPU.

## ✅ Achievements
- ROCm 6.2 stack fully operational
- HIP hello world compiled and executed
- Torch inference (Qwen 7B) successful on ROCm stack
- Device permissions (`/dev/kfd`) verified
- Own HIP projects built and tested (LLVM 18)

## 📂 Content
| File / Folder              | Description                                 |
|-----------------------------|---------------------------------------------|
| `rocm_7900xtx_setup.md`      | Full setup description and validation notes |
| `venv_setup.sh`             | Script to set up Python venv and install Torch |
| `environment_checklist.md`  | Post-installation validation checklist     |
| `hip_hello_world/`            | Minimal HIP project for testing          |
| `screenshots/`              | Screenshots of tests and GPU detection    |

## 📌 Important
This validation is part of a larger effort to enable **affordable, AMD-based AI research setups** for universities, security research groups, and emerging economies.

Maintainer: KI-Horscht | [kihorscht@gmail.com](mailto:kihorscht@gmail.com)
