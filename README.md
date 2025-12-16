# Dragonfly GTM Presentation

This repository contains the Reveal.js presentation for the Dragonfly 2026 GTM Strategy.

## 🚀 Quick Start

The project includes a helper script `start.sh` to make running and sharing the presentation easy.

### Prerequisites

- **Python 3** (usually pre-installed on macOS/Linux)
- **Ngrok** (optional, for public sharing)
  - Install via Homebrew: `brew install ngrok/ngrok/ngrok`
  - Or manually from [ngrok.com](https://ngrok.com)

### 1. Run Locally

To start a local server and open the presentation in your default browser:

```bash
./start.sh
```

- Access at: `http://localhost:8000`
- The script uses Python's `http.server` to serve the `presentation/` directory.

### 2. Share via Ngrok

To expose your local server to the internet for sharing (e.g., with a client or colleague):

```bash
./start.sh --ngrok
```

- This will start the local server AND an Ngrok tunnel.
- The script will output a public URL (e.g., `https://random-id.ngrok-free.app`).
- **Note:** You must have `ngrok` installed and authenticated (`ngrok config add-authtoken <token>`).

## 🛠 Project Structure

- `presentation/index.html`: The main entry point containing the Reveal.js setup and custom logic.
- `presentation/gtm_strat.md`: The content source (Markdown).
- `start.sh`: Helper script for automation.
