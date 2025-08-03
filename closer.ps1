# Get the process ID of "AutoHotkey.exe" with the specified window title
$pondProcess = Get-WmiObject Win32_Process | Where-Object { $_.CommandLine -like '*pond.ahk*' }

# Check if the process exists
if ($null -ne $pondProcess) {
    # Terminate the process
    Stop-Process -Id $pondProcess.ProcessId -Force
    Write-Host "pond.ahk process terminated successfully."
} else {
    Write-Host "pond.ahk process not found."
}