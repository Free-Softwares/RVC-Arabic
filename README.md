# 🎙️ RVC Voice Changer - Arabic Edition

**RVC (Retrieval-based Voice Conversion) Voice Changer – Arabic Edition** is a powerful real-time voice conversion tool that enables you to change your voice into any trained Arabic voice model using state-of-the-art AI.

This edition is specially optimized for Arabic voices, supporting dialects like Egyptian, Levantine, Gulf, and MSA (Modern Standard Arabic).

---

## 🌟 Features

- 🎤 Real-time voice conversion
- 🗣️ Arabic voice model support
- 🛠️ Easy-to-use web or desktop interface
- 🧠 High-accuracy voice cloning (RVC v2)
- 🔁 Training & inference support for custom voices
- 🎛️ Audio effects and noise suppression options

---

## 📦 Installation

> ⚠️ Requirements: Python 3.8+, NVIDIA GPU with CUDA support (for best performance)

### 1. Clone the repository
cd rvc-arabic-edition
2. Create a virtual environment and install dependencies
bash
Copy
Edit
python -m venv venv
source venv/bin/activate  # For Windows: venv\Scripts\activate
pip install -r requirements.txt
3. Download Arabic voice models
You can download pre-trained Arabic voices from this link (replace with actual link) and place them in the models/ folder.

🚀 Running the Application
Real-time Voice Changer (Web GUI)
bash
Copy
Edit
python infer-web.py
Open your browser and go to http://localhost:7865

🎙️ Using Custom Arabic Voices
To train your own Arabic voice model:

Prepare 10–30 minutes of clean voice data (WAV/FLAC).

Follow the instructions in the training/README.md.

Train the model and export it to models/your_model_name/.

📁 Project Structure
bash
Copy
Edit
rvc-arabic-edition/
├── models/             # Pre-trained Arabic voice models
├── audio_samples/      # Input/output samples
├── infer-web.py        # Web-based real-time inference
├── train/              # Training pipeline for custom voices
├── res/    # Python dependencies
└── README.md           # You're here!
🔊 Pre-trained Arabic Voice Models
Voice Name	Dialect	Gender	Demo Link
Layla	Egyptian	Female	🔗 Listen
Omar	MSA	Male	🔗 Listen
Nour	Levantine	Female	🔗 Listen

(More voices available in the models directory)

🛠️ Troubleshooting
No audio output: Ensure your input device and output device are selected correctly.

CUDA error: Verify your GPU drivers and CUDA toolkit are properly installed.

Model not loading: Make sure the model files are in the correct directory (models/your_model/).

📜 License
MIT License – See LICENSE file for details.

❤️ Special Thanks
RVC Project
