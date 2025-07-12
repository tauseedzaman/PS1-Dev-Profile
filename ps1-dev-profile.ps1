#================================================
#                Functins
#================================================

<#
.SYNOPSIS
    downloads file using Background Intelligent Transfer Service BITS 
.NOTES
    Author: tauseedzaman
    Date: 12/07/2025
#>
function  Start-FileDownload {
    param (
        [Parameter(Mandatory)]
        [string]$Url,

        [string]$Destination,

        [string]$DisplayName
    )

    try {
        # if url is not valid show error
        if (-not $Url -or $Url -notmatch '^(http|https)://') {
            Write-Host "Invalid URL provided. Please provide a valid URL." -ForegroundColor Red
            return
        }
        
        # Infer destination path if not provided
        if (-not $Destination) {
            $fileName = [System.IO.Path]::GetFileName($Url)
            $downloadsFolder = Join-Path -Path ([Environment]::GetFolderPath("UserProfile")) -ChildPath "Downloads"
            $Destination = Join-Path -Path $downloadsFolder -ChildPath $fileName
        }

        # Infer display name from filename if not provided
        if (-not $DisplayName) {
            $DisplayName = [System.IO.Path]::GetFileName($Destination)
            $DisplayName = $DisplayName -replace '-', ' ' -replace '_', ' '
            $DisplayName = $DisplayName.Substring(0, 1).ToUpper() + $DisplayName.Substring(1)
        }

        # Create destination folder if needed
        $destFolder = Split-Path -Path $Destination
        if (-not (Test-Path $destFolder)) {
            New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
        }

        Write-Host "`nStarting download: $DisplayName" -ForegroundColor Cyan
        Write-Host "Source:      $Url"
        Write-Host "Destination: $Destination"

        Start-BitsTransfer -Source $Url -Destination $Destination -DisplayName $DisplayName -Description "Downloading File to $Destination" -ErrorAction Stop

        Write-Host "Download completed: $DisplayName" -ForegroundColor Green
    }
    catch {
        Write-Host "Download failed: $_" -ForegroundColor Red
    }
}

<#
.SYNOPSIS
    Copies the current working directory path to the clipboard.
.NOTES
    Author: tauseedzaman
    Date: 14/05/2024
#>
function Copy-PathToClipboard {
    Get-Location | Set-Clipboard
}

<#
.SYNOPSIS
    Starts laravel development server.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function Start-LaravelServer {
    php artisan serve
}

<#
.SYNOPSIS
    runs php artisan in laravel project.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function Invoke-Artisan {
    php artisan $args
}

<#
.SYNOPSIS
    used to push git changes with one command passing message as a argument.
.NOTES
    Author: tauseedzaman
    Date: 15/05/2024
#>
function Push-GitChanges {
    param(
        [string]$CommitMessage
    )

    # Check if a commit message is provided
    if (-not $CommitMessage) {
        Write-Host "Please provide a commit message."
        return
    }

    # Execute Git commands
    git add .
    git commit -m $CommitMessage 
    git push
}

<#
.SYNOPSIS
    create file. if not argument is provided then tmp.txt is created.
.NOTES
    Author: tauseedzaman
    Date: 23/05/2024
#>
function New-File {
    param(
        [string]$fileName = "tmp.txt"
    )

    if (-not (Test-Path -Path "$fileName")) {
        New-Item -Type File -Name "$fileName"
    }
    else {
        Write-Host "$fileName already exists."
    }
}

<#
.SYNOPSIS
    Start PHP built-in web server
.NOTES
    Author: tauseedzaman
    Date: 23/05/2024
#>
function Start-phpserve {
    param(
        [string]$port = 8080
    )
    php -S localhost:$port
}

<#
.SYNOPSIS
    Start Python HTTP server
.NOTES
    Author: tauseedzaman
    Date: 23/05/2024
#>
function Start-PythonServer {
    param(
        [int]$port = 8080
    )
    python -m http.server $port
}

<#
.SYNOPSIS
    Scans the user's home directory and stores folder paths in a file.
.NOTES
    Author: tauseedzaman
    Date: 25/05/2024
#>
function Index-Folders {
    $userHome = [Environment]::GetFolderPath("UserProfile")
    $outputFile = Join-Path $userHome "folderPaths.txt"
    $excludeDirs = @(
        'node_modules',
        'vendor',
        'bower_components',
        'bin',
        'obj',
        'packages',
        'temp',
        'directory1',
        'directory2',
        'directory3',
        'lib',
        'vendor.bundle',
        'java_modules',
        'python_modules',
        'ruby_modules',
        'php_modules',
        'go_modules',
        'rust_modules'
    )

    # Function to check if a directory should be excluded
    function ShouldExclude($dir) {
        $excludeDirs -contains $dir.Name -or $dir.FullName -like '*\.*'
    }

    # Function to get directories up to a specific depth
    function Get-Directories($path, $depth, $seen) {
        if (-not $seen) {
            $seen = @{}
        }
    
        if ($depth -eq 0) {
            return @()
        }
    
        $dirs = Get-ChildItem -Path $path -Directory -ErrorAction SilentlyContinue | Where-Object { -not (ShouldExclude $_) }
        $allDirs = @()
        foreach ($dir in $dirs) {
            if (-not $seen.ContainsKey($dir.FullName)) {
                $seen[$dir.FullName] = $true
                $allDirs += $dir
                $allDirs += Get-Directories -path $dir.FullName -depth ($depth - 1) -seen $seen
            }
        }
        return $allDirs
    }
    

    $folders = @()
    $allDirs = Get-Directories -path $userHome -depth 5

    $totalDirs = $allDirs.Count
    $counter = 0

    foreach ($dir in $allDirs) {
        $counter++
        # Update progress bar
        Write-Progress -Activity "Scanning directories" -Status "$counter of $totalDirs" -PercentComplete (($counter / $totalDirs) * 100)
        $folders += "$($dir.FullName)"
    }

    $folders = $folders | Sort-Object -Unique
    $folders | Out-File -FilePath $outputFile -Force
    Write-Host "Folder paths updated and stored in $outputFile"
}

<#
.SYNOPSIS
    Navigates to a specified folder based on partial name.
.NOTES
    Author: tauseedzaman
    Date: 25/05/2024
#>
function Find-AndOpenFolder {
    param(
        [string]$DirectoryName
    )

    # Check if DirectoryName is provided
    if (-not $DirectoryName) {
        Write-Host "Please provide a directory name."
        return
    }

    # Split the provided directory name into individual directory names
    $directoryNames = $DirectoryName.Split("\")
    $userHome = [Environment]::GetFolderPath("UserProfile")
    $folderPathsFile = Join-Path $userHome "folderPaths.txt"

    # Check if folderPaths.txt exists
    if (-not (Test-Path $folderPathsFile)) {
        Write-Host "Folder paths file not found. Please run 'Scane-Folders' first."
        return
    }

    # Read the folder paths from the file
    $folders = Get-Content -Path $folderPathsFile

    # Initialize a list to store matched directories
    $matchedDirs = @()

    # Search for each directory name separately in the folder paths
    foreach ($dirName in $directoryNames) {
        $matchedDirs += $folders | Where-Object { $_ -like "*$dirName" }
    }

    # If no matching directory is found, notify the user
    if ($matchedDirs.Count -eq 0) {
        Write-Host "No directory found matching '$DirectoryName'."
        return
    }

    # If multiple directories match, prompt the user to choose one
    if ($matchedDirs.Count -gt 1) {
        Write-Host "Multiple directories found matching '$DirectoryName':"
        for ($i = 0; $i -lt $matchedDirs.Count; $i++) {
            Write-Host "$($i + 1): $($matchedDirs[$i])"
        }

        # Prompt user to select directory
        $selection = Read-Host "Please select a directory by entering its index"

        if ($selection -ge 1 -and $selection -le $matchedDirs.Count) {
            Set-Location $matchedDirs[$selection - 1]
        }
        else {
            Write-Host "Invalid selection. Please enter a valid index."
        }
        return
    }

    # If only one directory matches, navigate to it
    Set-Location $matchedDirs[0]
}

# other methods
function Open-InExplorer { explorer.exe . }
function Go-PreviousDirectory { cd .. }
function New-AndEnterFolder {
    param([string]$DirectoryName) 
    # Check if DirectoryName is provided
    if (-not $DirectoryName) {
        Write-Host "Please provide a directory name."
        return
    }

    mkdir $DirectoryName; 
    cd $DirectoryName 
}

function Get-FileHead {
    param(
        [string]$file,
        [int]$count = 10
    )
  
    if (!(Test-Path -Path $file)) {
        Write-Error "File not found: $file"
        return
    }
  
    Get-Content -Path $file -TotalCount $count
}
  
function Get-FileTail {
    param(
        [string]$file,
        [int]$count = 10
    )
  
    if (!(Test-Path -Path $file)) {
        Write-Error "File not found: $file"
        return
    }
  
    Get-Content -Path $file -Tail $count
}

#================================================
#                Aliases
#================================================
Set-Alias -Name cpwd -Value Copy-PathToClipboard -Description "Copy current working directory path to clipboard"
Set-Alias -Name pas -Value Start-LaravelServer -Description "Starts laravel development server"
Set-Alias -Name pa -Value Invoke-Artisan -Description "runs php artisan in laravel project."
Set-Alias -Name gpush -Value Push-GitChanges -Description "used to push git changes with one command passing message as a argument."
Set-Alias -Name touch -Value New-File -Description "create file if not argument is provided then tmp.txt is created."
Set-Alias -Name phpserve -Value Start-phpserve -Description "Start PHP built-in web server"
Set-Alias -Name pyserve -Value Start-PythonServer -Description "Start Python HTTP server"
Set-Alias -Name gt -Value Find-AndOpenFolder -Description "Navigates to a specified folder based on partial name."
Set-Alias -Name Scane-Folders -Value Index-Folders -Description "Scans the user's home directory and stores folder paths in a file."
Set-Alias -Name ex -Value Open-InExplorer -Description "Open current directory in File Explorer"
Set-Alias -Name b -Value Go-PreviousDirectory -Description "Go back to the previous directory"
Set-Alias -Name mkg -Value New-AndEnterFolder -Description "Create a directory and navigate into it"
Set-Alias -Name head -Value Get-FileHead -Description "Display the first few lines of a file"
Set-Alias -Name tail -Value Get-FileTail -Description "Display the last few lines of a file"
Set-Alias -Name dl -Value  Start-FileDownload -Description "Download a file using BITS"
