$timetag = (Get-Date -Format "dd/MM/yyyy")
$csvName =  [System.String]::Concat("NPS-Log_", $timetag, ".csv")

#-----------Diese Variablen anpassen-----------
$csvDrive = "C:"
$csvPath = "Users\Public"
$logordner = "meinelogs"

#-----------Diese Variablen in Ruhe lassen-----------
$csvcombinepath = ("$csvDrive\$csvPath")
$csvFULLpfad = ("$csvDrive\$csvPath\$logordner\$csvName")
$checkpath = ("$csvDrive\$csvPath\$logordner")
$infostring = [System.String]::Concat("`n", "     ", $logordner, " NICHT vorhanden!", "`n", "   Erstelle ", $csvFULLpfad, "!")
 
#-----------Teste ob der Pfad vorhanden ist-------------------
If(!(test-path $checkpath))
{
#-----------Pfad vorhanden------------------------------------
    Write-Host $infostring
    
    New-Item -Path $csvcombinepath -Name $logordner -ItemType "directory"
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad
}
else {
#-----------Pfad nicht vorhanden--------------------------------
    Write-Host "Der Pfad ist vorhanden und die Datei", $csvname, "wurde dort abgelegt."
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad -append 
}
#-------------------------------------------------------------------------