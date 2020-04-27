<#
npsLogger.ps1
.DESCRIPTION
    - Script angeeinetem Ort speichern
    - Geplante Task erstellen
        - Benutzer oder Gruppe auswaehlen BSP LocalComputer\Users
        - Neuer Trigger: Täglich, jede Stunde
        - Aktion: Programm starten
            * Powershell.exe
            * Argumente: -windowsstyle hidden -command .\netsharestarter.ps1
            * Starten in: Speicherort des Scripts
        * Nur starten wenn folgende Netzwerkverbindung verfuegbar ist: Beliebige NIC

https://github.com/thelamescriptkiddiejan/powershell/blob/master/npsLogger.ps1
#>
#--- Vorbereitung -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
$infostring = [System.String]::Concat("`n", "     ", $logordner, " NICHT vorhanden!", "`n", "   Erstelle ", $checkpath, "!")
$infostring2 = [System.String]::Concat("`n", "     ", "Erstelle", $csvName, " !")
$infostring3 = [System.String]::Concat("`n", "     ", $logordner, " vorhanden!", "`n")
 
#-----------Teste ob der Pfad vorhanden ist-------------------
If(!(test-path $checkpath))
{
#-----------Pfad vorhanden------------------------------------
    Write-Host $infostring
    
    New-Item -Path $csvcombinepath -Name $logordner -ItemType "directory"
    if (!(test-path $csvFULLpath))
    {
        Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad
        $infostring2
    }
}
else {
#-----------Pfad nicht vorhanden--------------------------------
    Write-Host $infostring3
    Get-EventLog -LogName System -After (get-date).addminutes(-60) -EntryType error -Source "NPS" | Export-CSV $csvFULLpfad -append 
}
#-------------------------------------------------------------------------