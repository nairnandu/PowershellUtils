Write-Host "Getting Applications..."
$result = Invoke-Command -ComputerName (Get-Content ".\MachineList.txt") -ScriptBlock {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | select DisplayName, Publisher, DisplayVersion, InstallDate, InstallLocation, InstallSource, ModifyPath, EstimatedSize, Language, UninstallString, URLInfoAbout, URLUpdateInfo, HelpLink; 
    Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | select DisplayName, Publisher, DisplayVersion, InstallDate, InstallLocation, InstallSource, ModifyPath, EstimatedSize, Language, UninstallString, URLInfoAbout, URLUpdateInfo, HelpLink
}
$result | Export-Csv -Path ApplicationsInstalled.csv -Delimiter "`t"
Write-Host "Done. Data written out to ApplicationsInstalled.csv"

Write-Host "Getting Hotfixes..."
$hotfixes = Get-WmiObject -ComputerName (Get-Content ".\MachineList.txt") -Class "win32_quickfixengineering" | Select-Object -Property "CSName", "Description", "HotfixID", @{Name="InstalledOn"; Expression={([DateTime]($_.InstalledOn)).ToLocalTime()}} 
$hotfixes | Export-Csv -Path HotfixesInstalled.csv -Delimiter "`t"
Write-Host "Done. Data written out to HotfixesInstalled.csv"

Read-Host "Completed. Press enter to exit."