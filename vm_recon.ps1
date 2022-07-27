#########################################################
# Determine the name of VM
#"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list vms

# MY_VM
$vm_name='Minicube'

# MY_IP
$ip = "192.168.1.123"

#########################################################
#https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-controlvm.html
#Virtual Box managment interface
$vbM_Path="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

#########################################################
# Determine the name of network interface
#"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list bridgedifs
$nic1 = "Intel(R) Wi-Fi 6 AX201 160MHz"
$nic2 = "Realtek USB GbE Family Controller"



#pinging MY_IP by .Net
$res = [System.Net.NetworkInformation.Ping]::new().Send($ip).Status
Write-Host "Vm is UP:"$ip $res


#verify if  $nic2 is UP
#(Get-NetAdapter -InterfaceDescription $nic2 -Physical).Status -eq "Up"

if ($res -ne "Success")
{
    if ((Get-NetAdapter -InterfaceDescription $nic2 -Physical).Status -eq "Up")
    {
       & echo "Briged adapter is " $nic2
       &"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 nat $nic2   
       Start-Sleep -m 500  
       &"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 bridged $nic2
    } 
    else
    {
       & echo "Briged adapter is " $nic1
       &"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 nat $nic1   
       Start-Sleep -m 500  
       &"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 bridged $nic1
    }
}
