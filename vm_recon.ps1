#########################################################
# Determine the name of VM
#"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list vms

# MY_VM
$vm_name='Minicube'

# MY_IP
$vm_ip = "192.168.1.123"

#########################################################
#https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-controlvm.html
#Virtual Box managment interface
#$vbM_Path="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
$VBox_ControlVm_Path="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

#########################################################
# Determine the name of network interface
#"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list bridgedifs
$nic1 = "Intel(R) Wi-Fi 6 AX201 160MHz"
$nic2 = "Realtek USB GbE Family Controller"



#pinging MY_IP by .Net
$res = [System.Net.NetworkInformation.Ping]::new().Send($vm_ip).Status
Write-Host "Vm is UP:"$vm_ip $res


#verify if  $nic2 is UP
#(Get-NetAdapter -InterfaceDescription $nic2 -Physical).Status -eq "Up"

if ($res -ne "Success")
{
    # VM briget with wrong interface 
    # fixing briged interface
    
    if ((Get-NetAdapter -InterfaceDescription $nic2 -Physical).Status -eq "Up")
    {
           ##& echo "Briged adapter is `"$nic1`""
           ##&"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 nat $nic1   
           ##Start-Sleep -m 500  
           ##&"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $vm_name nic1 bridged $nic1     

           & echo "Briged adapter is `"$nic2`""
           &$VBox_ControlVm_Path controlvm $vm_name nic1 nat $nic2   
           Start-Sleep -m 500  
           &$VBox_ControlVm_Path controlvm $vm_name nic1 bridged $nic2
    } 
    

    # If Fixing of VM briged interface dosn`t help
    # The problem inside VirtualBox - "ARP routing problem"

    if ([System.Net.NetworkInformation.Ping]::new().Send($vm_ip).Status -ne "Success")
    {

           #Empty array of running VNs
           $VM_list=@()
       
           # Logging on screen and creating array of running VMs
           Write-Host "List of running VMs:"
           foreach($VM_str in (&$VBox_ControlVm_Path list runningvms)) {
            Write-Host $VM_str
            $VM_list+= $VM_str.Split()[0]
           }
           
           # Founded solution: Poweroff all VMs and Poweron
           
           #&VBox_ControlVm_Path poweroff $vm_name           
           $VM_list | ForEach-Object { &$VBox_ControlVm_Path controlvm $_ poweroff }            
           Start-Sleep -m 500
           #&VBox_ControlVm_Path startvm $vm_name
           $VM_list | ForEach-Object { &$VBox_ControlVm_Path startvm $_ }
    }
}
