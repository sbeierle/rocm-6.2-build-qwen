
---

### 4. ⚠️ Known Issues and Solutions 

```markdown
# Known Issues and Solutions (gfx1100 ROCm 6.2)

## Issue: `rocminfo` shows no devices
- Solution: Ensure that the user is in the `video` group and `/dev/kfd` has correct permissions.

## Issue: HIP programs fail to compile
- Solution: Set `export HSA_OVERRIDE_GFX_VERSION=11.0.0` before compiling.

## Issue: HIP or ROCm libraries missing
- Solution: Install full `rocm-dev`, `hip-runtime-amd`, and `rocm-hip-runtime` packages via APT.

## Issue: Torch inference extremely slow or crashes
- Solution: Ensure correct ROCm-specific Torch installed via:
  ```bash
  pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.1



Issue: FlashAttention warnings (experimental SDPA)
Solution: Ignore for now; ROCm 6.2 partial support only. Functionality not critical.

Issue: torch.cuda.is_available() returns False
Solution: Double-check all export variables, especially HSA_OVERRIDE_GFX_VERSION and HIP settings.

