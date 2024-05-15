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

<#
.SYNOPSIS
    Starts laravel development server.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function Start-laravelDevelopmentServer {
    php artisan serve
}

<#
.SYNOPSIS
    runs php artisan in laravel project.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function Start-ArtisanCommand {
    php artisan $args
}

<#
.SYNOPSIS
    used to push git changes with one command passing message as a argument.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function GitPush {
    param(
        [string]$CommitMessage
    )

    # Check if a commit message is provided
    if (-not $CommitMessage) {
        Write-Host "Please provide a commit message."
        return
    }

    # Check if .git folder exists in the current directory
    $GitFolderPath = Get-Location
    if (-not (Test-Path -Path (Join-Path -Path $GitFolderPath -ChildPath ".git"))) {
        Write-Host "Git repository not found in the current directory."
        return
    }

    # Read repository name from .git/config file
    $ConfigPath = Join-Path -Path $GitFolderPath -ChildPath ".git\config"
    $Repository = $null

    $content = Get-Content $ConfigPath

    foreach ($line in $content) {
        if ($line -match "url = .+/(.+)\.git") {
            $Repository = $matches[1]
            break
        }
    }

    # If repository name is not found, exit
    if (-not $Repository) {
        Write-Host "Repository name not found."
        return
    }

    # Execute Git commands
    git add .
    git commit -m $CommitMessage 
    git push
}

#================================================
#                Aliases
#================================================
Set-Alias -Name cpwd -Value Copy-CurrentPathToClipboard -Description "Copy current working directory path to clipboard"
Set-Alias -Name pas -Value Start-laravelDevelopmentServer -Description "Starts laravel development server"
Set-Alias -Name pa -Value Start-ArtisanCommand -Description "runs php artisan in laravel project."
Set-Alias -Name gpush -Value GitPush -Description "used to push git changes with one command passing message as a argument."