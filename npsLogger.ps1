$timetag = (Get-Date -Format "dd/MM/yyyy")
$csvName =  [System.String]::Concat("NPS-Log_", $timetag, ".csv")
$csvDrive = "C:"
$csvPath = "Users\Public\meinelogs"
$csvFULLpfad = ("$csvDrive\$csvPath\$csvName")
$checkpath = ("$csvDrive\$csvPath")
 
#--------------------------------------------------------





If(!(test-path $checkpath))
{
    New-Item -Path $csvDrive -Name $csvPath -ItemType "directory"
    
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error | Export-CSV $csvFULLpfad
    Start-Sleep -Seconds 1.5
}
else {
    Start-Sleep -Seconds 1.5
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error | Export-CSV $csvFULLpfad -append 
}
#-------------------------------------------------------------------------







