# Mermaid + Reveal.js Presentation Template

A "fork & use" template for building beautiful, code-driven presentations with **Mermaid.js** diagrams and **Markdown**.

**Why use this?**
- 📝 Write content in Markdown (`gtm_strat.md`).
- 📊 Diagrams render automatically from code (Mermaid.js).
- 🎨 Beautiful, simple styling (Inter font, Dark mode).
- 🚀 One-command start & share.

## ⚡️ Quick Start

### 1. Run it
```bash
./start.sh
```
*Autosystematically opens `http://localhost:8000` in your browser.*

### 2. Customize it
1. Open `presentation/gtm_strat.md`.
2. Edit the Markdown.
3. Refresh browser.

### 3. Share it
```bash
./start.sh --ngrok
```
*Generates a public URL to share instantly.*

#### 🛠 Ngrok Setup
If you don't have ngrok installed:
1. **Install:**
   - macOS: `brew install ngrok/ngrok/ngrok`
   - Linux/Windows: Download from [ngrok.com](https://ngrok.com/download)
2. **Authenticate:** 
   - Sign up at ngrok.com to get your auth token.
   - Run: `ngrok config add-authtoken YOUR_TOKEN_HERE`

### 4. Push Changes
To save your edits and push them back to GitHub:
```bash
git add .
git commit -m "Update presentation content"
git push
```

### 5. Customize Tab Name & Icon
To change the browser tab name and icon:
1. Open `presentation/index.html`.
2. **Tab Name:** Edit the text inside the `<title>` tag (Line 8).
3. **Tab Icon (Favicon):** Edit the `<link rel="icon">` tag (Line 9). Point the `href` to your image file.

## 🛠 Compatibility

Works on macOS, Linux, and Windows (via WSL). Requires Python installed (standard on most systems).

---
*Powered by [Reveal.js](https://revealjs.com) and [Mermaid.js](https://mermaid.js.org).*
