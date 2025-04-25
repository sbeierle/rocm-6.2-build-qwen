

```markdown
# 🔧 إعداد Qwen 7B باستخدام ROCm 6.1 (AMD RX 7900 | Torch | Safetensors)

> ✅ إعداد كامل يعمل محليًا لـ Qwen 7B باستخدام ROCm + Torch + Safetensors  
> 🧠 تركيز البحث: الهندسة العكسية الأخلاقية لنماذج اللغة والاختبار الأمني (Red Teaming)  
> ⚙️ العتاد: AMD Radeon RX 7900 XTX | ROCm 6.1 | Python 3.10 / 3.12 | نواة لينكس 6.11 (Ubuntu 24.10)

---

## 📦 وصف المشروع

هذا المستودع يوثق بيئة ROCm مستقرة لتشغيل نموذج Qwen 7B محليًا باستخدام معالج AMD.  
يُعد جزءًا من مبادرة بحثية في تحليل النماذج اللغوية هندسيًا، وتحليل ملفات safetensors، وفهم القيود المطبقة.

**الميزات:**

- تثبيت ROCm 6.1 باستخدام APT، متكامل مع HIP وTorch
- اختُبر على Ubuntu 22.04 (Python 3.10) و Ubuntu 24.10 (Python 3.12)
- دعم كامل لتنسيق `.safetensors`
- إعداد متكامل للبيئة الافتراضية (venv) وسكربتات bash
- عملية فك القيود الداخلية على Qwen 7B

---

## 🚀 البدء السريع

```bash
git clone https://github.com/sbeierle/rocm-6.1-stable-amd-qwen7b.git
cd rocm-6.1-stable-amd-qwen7b
bash scripts/start_qwen_env.sh
```

**متطلبات النظام:**

```markdown

- Ubuntu 22.04 أو 24.10
- Python 3.10 أو 3.12
- بطاقة AMD داعمة لـ ROCm (مثل RX 7900 XTX)
- 64 جيجابايت ذاكرة على الأقل، و 40 جيجابايت مساحة تخزين

---

## 🪡 مراحل المشروع (Qwen 7B)

| المرحلة | الخطوة                                                        |
|--------|----------------------------------------------------------------|
| 0      | تثبيت ROCm 6.1 وبيئة بايثون                                   |
| 1      | اختبار تشغيل النموذج بـ safetensors وتوثيق النتائج            |
| 2      | إنشاء نسخ احتياطية بعد كل تعديل مهم                           |
| 3      | اختبار المدخلات الحساسة باستخدام `prompt_critical_tester`    |
| 4      | تعديل وزن الكلمات المقيدة (تفاصيل خاصة)                       |

إنشاء نسخة احتياطية تلقائيًا بعد كل مرحلة:

```bash
tar -czf ~/snapshots/qwen7b_phase$(date +%Y%m%d_%H%M).tar.gz ~/models/Qwen2.5-7B-Instruct
```

---

## 🔍 خطوات التثبيت (Ubuntu 24.10)

### 1. إضافة مستودع AMD ROCm

```bash
wget https://repo.radeon.com/amdgpu-install/6.1.0/ubuntu/jammy/amdgpu-install_6.1.60100-1_all.deb
sudo apt install ./amdgpu-install_6.1.60100-1_all.deb
sudo amdgpu-install --usecase=rocm --no-dkms
```

### 2. تثبيت المتطلبات الأساسية

```bash
sudo apt install git wget build-essential python3.12 python3.12-venv
```

### 3. إعداد Python و Torch

```bash
python3.12 -m venv rocm_env
source rocm_env/bin/activate
pip install --upgrade pip
pip install "numpy<2.0.0"
pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.1
pip install transformers safetensors accelerate
```

### 4. تعيين متغيرات البيئة الخاصة بـ ROCm

```bash
export ROCM_HOME=/opt/rocm
export HIP_PATH=/opt/rocm
export PATH=$ROCM_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$LD_LIBRARY_PATH
export HSA_OVERRIDE_GFX_VERSION=11.0.0
```

---

## 🧪 اختبار البيئة

```bash
rocminfo | grep gfx
/opt/rocm/bin/rocm-smi
python -c "import torch; print(torch.cuda.is_ava

```markdownilable())"
```

**الناتج المتوقع:**

```
GPU erkannt: True
Gerät: AMD Radeon RX 7900 XTX
```

---

## 🧠 مثال على تشغيل النموذج (Qwen 7B)

```python
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch
model = AutoModelForCausalLM.from_pretrained("./models/Qwen2.5-7B-Instruct", torch_dtype=torch.float16, device_map="auto")
tokenizer = AutoTokenizer.from_pretrained("./models/Qwen2.5-7B-Instruct")
inputs = tokenizer("ما هي عاصمة بيرو؟", return_tensors="pt").to("cuda")
outputs = model.generate(**inputs, max_new_tokens=64)
print(tokenizer.decode(outputs[0], skip_special_tokens=True))
```

---

## 📂 الأدوات المضمنة

| الأداة                          | الوصف                                        |
|-------------------------------|-----------------------------------------------|
| `scripts/start_qwen_env.sh`   | تفعيل البيئة الافتراضية وضبط متغيرات ROCm   |
| `vector5_patcher.py`          | تعديل يدوي لأوزان الكلمات الحساسة            |
| `prompt_critical_tester_v6.py`| اختبار كلمات حساسة في النماذج                |
| `tensor_locator.py`           | تحديد مكان التنسورات داخل ملفات safetensors |
| `.gitignore`                  | استبعاد الملفات الكبيرة من التتبع            |

---

## 📌 ملاحظات

- النموذج المعدل يُستخدم فقط في سياقات بحثية

```markdown
- مشروع Qwen 32B قيد التطوير حالياً
- تفاصيل فك القيود غير منشورة حالياً
- نسخ احتياطية يتم إنشاؤها تلقائيًا بعد كل مرحلة
- البيئة تعمل بدون CUDA – تعتمد كليًا على ROCm
- متوافقة مع Python 3.10 و 3.12

---

## ⚠️ قانوني / الوصول

جميع المحتويات مخصصة **للبحث العلمي والتعليم**.\
لا يتم تضمين أي ملفات تنفيذية أو سكربتات فك قيود.

يمكن للمؤسسات أو فرق البحث المعتمدة طلب الوصول إلى نسخة Qwen 7B غير المقيدة بالإضافة إلى ملفات `critical_prompts`.

📬 للتواصل: [kihorscht@gmail.com](mailto:kihorscht@gmail.com)

---

المشرف: **KI-Horscht**  
GitHub: [https://github.com/Ki-Horscht](https://github.com/Ki-Horscht)
```

