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

    # Execute Git commands
    git add .
    git commit -m $CommitMessage 
    git push
}

<#
.SYNOPSIS
    create file. if not argument is provided then temp.txt is created.
.NOTES
    Author: tauseedzaman
    Date: 23/05/2024
#>
function createfile {
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
function PHP-Server {
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
function py-server {
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
function Update-FolderPaths {
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
function GoTo-Folder {
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
function Open-Explorer { explorer.exe . }
function Go-Back { cd .. }
function Make-Dir-And-Go {
    param([string]$DirectoryName) 
    # Check if DirectoryName is provided
    if (-not $DirectoryName) {
        Write-Host "Please provide a directory name."
        return
    }

    mkdir $DirectoryName; 
    cd $DirectoryName 
}


#================================================
#                Aliases
#================================================
Set-Alias -Name cpwd -Value Copy-CurrentPathToClipboard -Description "Copy current working directory path to clipboard"
Set-Alias -Name pas -Value Start-laravelDevelopmentServer -Description "Starts laravel development server"
Set-Alias -Name pa -Value Start-ArtisanCommand -Description "runs php artisan in laravel project."
Set-Alias -Name gpush -Value GitPush -Description "used to push git changes with one command passing message as a argument."
Set-Alias -Name touch -Value createfile -Description "create file if not argument is provided then temp.txt is created."
Set-Alias -Name phpserver -Value PHP-Server -Description "Start PHP built-in web server"
Set-Alias -Name pyserver -Value py-server -Description "Start Python HTTP server"
Set-Alias -Name gt -Value GoTo-Folder -Description "Navigates to a specified folder based on partial name."
Set-Alias -Name Scane-Folders -Value Update-FolderPaths -Description "Scans the user's home directory and stores folder paths in a file."
Set-Alias -Name ex -Value Open-Explorer -Description "Open current directory in File Explorer"
Set-Alias -Name b -Value Go-Back -Description "Go back to the previous directory"
Set-Alias -Name mkg -Value Make-Dir-And-Go -Description "Create a directory and navigate into it"
