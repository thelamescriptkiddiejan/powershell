$timetag = (Get-Date -Format "dd/MM/yyyy")
$csvName =  [System.String]::Concat("NPS-Log_", $timetag, ".csv")
$csvDrive = "C:"
$csvPath = "Users\Public"
$logordner = "meinelogs"
$csvcombinepath = ("$csvDrive\$csvPath")
$csvFULLpfad = ("$csvDrive\$csvPath\$logordner\$csvName")
$checkpath = ("$csvDrive\$csvPath\$logordner")

$infostring = [System.String]::Concat("`n", "     ", $logordner, " NICHT vorhanden!", "`n", "   Erstelle ", $csvFULLpfad, "!")
 
#--------------------------------------------------------




If(!(test-path $checkpath))
{
    
    Write-Host $infostring
    
    New-Item -Path $csvcombinepath -Name $logordner -ItemType "directory"
    
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad
    Start-Sleep -Seconds 1.5
}
else {

    Write-Host "   Pfad VORAHNDEN!!!1!!!111"

    Start-Sleep -Seconds 1.5
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad -append 
}
#-------------------------------------------------------------------------