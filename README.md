# **🎬 MPV Interactive Setup Wizard**

A beautiful, interactive, and bilingual (English/Vietnamese) CLI installer for the best **mpv player** scripts, OSCs (On-Screen Controllers), and add-ons. Built with [gum](https://github.com/charmbracelet/gum) for a premium terminal experience.

## **✨ Features**

* 🌍 **Bilingual Support**: The installer fully supports both English and Vietnamese.  
* 🎨 **Modern TUI**: Interactive menus using arrow keys and spacebar (Multi-select) powered by gum.  
* 🛡️ **Automatic Cleanup**: Detects and removes conflicting UI scripts (uosc, ModernX, etc.) to ensure a bug-free experience.  
* 📦 **Curated Collection**: Includes top-rated scripts from the awesome-mpv repository.  
* ⚡ **Smart Installer**: Handles complex installations like uosc (zip extraction) and font embedding automatically.

## **🚀 Installation & Usage**

### **Prerequisites**

Ensure your system has curl, unzip, and gum installed.  
**Install gum:**

* **macOS:**
```
brew install gum
```  
* **Arch Linux:**
```
 sudo pacman \-S gum
   ```                 
* **Ubuntu/Debian:**
```bash
sudo mkdir \-p /etc/apt/keyrings  
curl \-fsSL \[https://repo.charm.sh/apt/gpg.key\](https://repo.charm.sh/apt/gpg.key) | sudo gpg \--dearmor \-o /etc/apt/keyrings/charm.gpg  
echo "deb \[signed-by=/etc/apt/keyrings/charm.gpg\] \[https://repo.charm.sh/apt/\](https://repo.charm.sh/apt/) \* \*" | sudo tee /etc/apt/sources.list.d/charm.list  
sudo apt update && sudo apt install gum
```

### **One-Line Install**
Run the following command in your terminal to start the wizard directly:
```bash
curl -sL https://raw.githubusercontent.com/FeurisPT2/My_mpv/main/Mpv_aio.sh | bash
```
## **📦 What's Included?**

### **📺 Interfaces (OSC Replacements)**

*You can only install one at a time. The script handles the cleanup of previous themes automatically.*

* **uosc**: The ultimate feature-rich OSC with integrated context menus.  
* **ModernX**: Polished and modern, the most popular choice.  
* **ModernZ**: An upgraded version of ModernX with more features.  
* **osc-modern**: Minimalist and lightweight original design.  
* **Others**: progressbar, tethys, dark-box, light-box, mfpbar...

### **📝 Subtitle Tools (Multi-select)**

* **sub-select**: Smart track selection based on language rules.  
* **autosubsync**: Automatic subtitle synchronization.  
* **subai**: AI-powered translation and grammar explanation.  
* **autosub**: Automatic subtitle downloader.  
* **sub-pause**: Pauses video at the end of lines for listening practice.

### **🧩 Power Add-ons (Multi-select)**

* **Thumbfast**: High-performance on-the-fly thumbnails.  
* **SmartCopyPaste**: Copy/paste URLs directly into mpv.  
* **Autoload**: Automatically loads the next episodes in a folder.  
* **Mpv-WebM**: Easily create clips/GIFs from your video.  
* **PlaylistManager**: Advanced on-screen playlist management.  
* **Memo/History**: Remembers your recently played files and position.

## **🤝 Credits**

Special thanks to the creators of these amazing scripts:

* [awesome-mpv](https://github.com/stax76/awesome-mpv) for the curated list.  
* [tomasklaen](https://github.com/tomasklaen/uosc) for uosc.  
* [cyl0](https://github.com/cyl0/ModernX) for ModernX.  
* [Samillion](https://github.com/Samillion/ModernZ) for ModernZ.  
* [po5](https://github.com/po5/thumbfast) for thumbfast.

## **📜 License**

This installer is licensed under the [MIT License](http://docs.google.com/LICENSE). Note that individual mpv scripts are subject to their respective authors' licenses (GPL, LGPL, MIT, etc.).
