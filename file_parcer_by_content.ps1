#Input filename
$in_file = "Book1.csv"
$sk_file = "Book1.csv.skipped_lines." + (get-date).ToString("yyyy_MM_dd_HHmmss")
#output directory name
$out_dir = ".\OUTPUT\"

##################################################
#Create directory if it does not exist 
#and hide output of command
if (Test-Path -Path .\output) {   
   $null = New-Item -ItemType Directory -Force -Path $out_dir
}

##################################################
#Create directory if it does not exist 
#and hide output of command
if (Test-Path -Path $sk_file) {   
   $null = New-Item -ItemType Directory -Force -Path $out_dir
}


##################################################
#Processing line from csv file
foreach($line in Get-Content .\$in_file) {

    #escaping spaces and special symbols and preparing to processing
    #$item_name= '"'+ ($line -replace ',' ,'"\"') +'"'
    $part1 = $line.Substring(0, $line.IndexOf(","))
    $part2 = $line.Substring($line.IndexOf(',')+1)

    $item_name= ($part2 + '\' +  $part1)
    write-host $item_name
    
    #expracting filename from line
    $f_name = $item_name.Substring($item_name.IndexOf('\')+1)
    
    #verifying if file exist in local folder
    if (Test-Path -Path ('.\' + $part1)){
                
        #create appropriate folder
        write-host $part2.replace('/','\')
        New-Item -ItemType Directory -Force -Path $part2.replace('/','\')
        
        #Move-Item -Path .\$f_name -Destination ($out_dir + '\' + $item_name.Substring(0, $item_name.IndexOf("\")))
        #Copy-Item -Path .\$f_name -Destination ($out_dir + '\' + $item_name.Substring(0, $item_name.IndexOf("\")))

    } else {
        write-host 'File was skipped:' $f_name.replace('"','')
        #skiped line was added to file to continue manual processing
        $line | Out-File -append $sk_file
        
    }
}
