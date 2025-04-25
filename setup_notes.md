# 🔧 Setup Notes (Submodules & Exports)

## 🔁 Git Submodules (optional)

Falls du das Repo mit eingebetteten Submodulen (z. B. `transformers`, `qwen-custom`, etc.) erweitert hast, nutze den folgenden Clone-Befehl:

```bash
# 🔄 Cloning with submodules
git clone --recurse-submodules https://github.com/sbeierle/rocm-6.2-build-qwen.git
cd rocm-6.2-build-qwen

# Falls du das Repo bereits geklont hast, dann:
git submodule update --init --recursive
```

💡 Submodule eignen sich hervorragend, um eigene Forks, Tools oder `llama.cpp`/`transformers`-Abhängigkeiten direkt mit einzubinden.

## 📤 Persistent ROCm Export Blocks

Da ROCm-Setups oft fragile Umgebungsvariablen brauchen, empfiehlt sich ein zentraler Export-Block wie z. B.:

```bash
# 📁 scripts/start_qwen_env.sh
export ROCM_HOME=/opt/rocm
export HIP_PATH=/opt/rocm
export PATH=$ROCM_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$LD_LIBRARY_PATH
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export HIP_VISIBLE_DEVICES=0
```

Alternativ dauerhaft in `~/.bashrc` setzen:

```bash
echo "export ROCM_HOME=/opt/rocm" >> ~/.bashrc
echo "export PATH=\$ROCM_HOME/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$ROCM_HOME/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
```

## 🧪 Sanity Checks

```bash
rocminfo | grep gfx
/opt/rocm/bin/rocm-smi
python -c "import torch; print(torch.cuda.is_available())"
```

---

# 🧩 Known Issues & Fixes

| Problem                            | Lösung / Workaround                                                |
|------------------------------------|---------------------------------------------------------------------|
| `torch.cuda.is_available() = False`| Export-Variablen prüfen: `HIP_VISIBLE_DEVICES`, `HSA_OVERRIDE_*`   |
| ROCm nicht auffindbar              | Prüfen ob `/opt/rocm` korrekt verlinkt ist (`/opt/rocm-6.2.x`)     |
| `safetensors` Error bei Torchload  | Nur Python ≥ 3.10 & neueste `safetensors` via `pip install` nutzen |
| Kernelwarnungen (SDPA etc.)        | FlashAttention auf Navi31 ist experimentell – ignorierbar          |
| Submodules fehlen                  | `git submodule update --init --recursive` ausführen                |
| NumPy 2.0 breaks builds            | Fix: `pip install "numpy<2.0.0"`                                   |

---

📍 Tipp: Logs & Bash-History regelmäßig sichern!
