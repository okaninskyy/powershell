# PowerShell Scripts Collection

A set of simple but practical PowerShell scripts for automation and troubleshooting.

## 📂 Scripts

### 🔧 vm_recon.ps1

Fixes VirtualBox network issues after WiFi reconnect.

* Checks VM connectivity
* Switches bridged adapter
* Handles multiple network interfaces (different providers)
* Restarts VMs if needed
  
### 📁 file_parser_by_content.ps1

Processes files based on CSV input.

* Input: CSV with file name + destination folder
* Creates directories automatically
* Logs skipped files

## 🚀 Usage

Run scripts in PowerShell:

```powershell
.\vm_recon.ps1
.\file_parser_by_content.ps1
```

## 🛠 Requirements

* Windows
* PowerShell 5+
* VirtualBox (for vm_recon.ps1)

## 📌 Notes

These scripts are experimental but useful for everyday automation.
