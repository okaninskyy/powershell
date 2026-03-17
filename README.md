# powershell
Several simple scripts

#WiFi #VirtualBox #DroppedConnection
  - vm_recon.ps1 - This script attempts to recover a VirtualBox VM network connection after the        host reconnects to Wi-Fi. It checks whether the VM is reachable, switches the bridged adapter if    needed, and, if that does not help, power-cycles running VMs as a workaround for VirtualBox         networking issues.

#FileManagement #CSV #PowerShell

  - file_parcer_by_content.ps1 - This script processes a CSV file with 2 columns:
    1. file name;
    2. destination folder;
  
  For each row, it checks whether the file exists in the current folder.
  If the file exists, it creates the target folder.
  If the file does not exist, the row is written to a skipped-lines log file for manual review.
