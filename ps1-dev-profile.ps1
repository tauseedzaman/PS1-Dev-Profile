#================================================
#                Functins
#================================================

<#
.SYNOPSIS
    Copies the current working directory path to the clipboard.
.NOTES
    Author: tauseedzaman
    Date: 14/05/2024
#>
function Copy-CurrentPathToClipboard {
    Get-Location | Set-Clipboard
}
  

#================================================
#                Aliases
#================================================
Set-Alias -Name cpwd -Value Copy-CurrentPathToClipboard -Description "Copy current working directory path to clipboard"