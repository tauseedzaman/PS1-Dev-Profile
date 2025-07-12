# PowerShell Profile For Developers

## Overview

This repository contains a collection of useful PowerShell functions and aliases for developers. The goal is to provide a starting point for developers to customize their PowerShell profiles and share their own contributions.

## 📘 Alias Index

1. **[`cpwd`](#cpwd)** — Copies current path to clipboard  
   → `Copy-PathToClipboard`

2. **[`pas`](#pas)** — Starts Laravel development server  
   → `Start-LaravelServer`

3. **[`pa`](#pa)** — Runs `php artisan` in Laravel project  
   → `Invoke-Artisan`

4. **[`gpush`](#gpush)** — Push git changes with a commit message  
   → `Push-GitChanges`

5. **[`touch`](#touch)** — Creates a file (defaults to `tmp.txt` if no name provided)  
   → `New-File`

6. **[`phpserve`](#phpserve)** — Starts PHP built-in web server  
   → `Start-phpserve`

7. **[`pyserve`](#pyserve)** — Starts Python HTTP server  
   → `Start-PythonServer`

8. **[`gt`](#gt)** — Navigate to a folder using a partial name  
   → `Find-AndOpenFolder`

9. **[`Scane-Folders`](#Scane-Folders)** — Scan and cache folder paths from home directory  
   → `Index-Folders`

10. **[`ex`](#ex)** — Open current directory in File Explorer  
    → `Open-InExplorer`

11. **[`b`](#b)** — Go back to the previous directory  
    → `Go-PreviousDirectory`

12. **[`mkg`](#mkg)** — Create a directory and enter it  
    → `New-AndEnterFolder`

13. **[`head`](#head)** — Show first few lines of a file  
    → `Get-FileHead`

14. **[`tail`](#tail)** — Show last few lines of a file  
    → `Get-FileTail`

15. **[`dl`](#dl)** — Download a file using BITS with resume support  
    → ` Start-FileDownload`

## Usage
To start using the PowerShell Developer Profile, follow these steps:

1. Clone the repository to your local machine:

   ```sh
   git clone https://github.com/tauseedzaman/PS1-Dev-Profile
   ```
2. Import the profile in your PowerShell environment. Open PowerShell and run:
   ```sh
   notepad $PROFILE
   ```
   Add the following line to your profile file:
   ```sh
   . <path-to-repo>\ps1-dev-profile.ps1
   ```

   Replace `<path-to-repo`> with the path to the cloned repository.

3. Save and close the profile file. Then restart PowerShell, and you're ready to go!



## Aliases

#### ⭕ <a name="cpwd">Copy Working Directory Path</a>

```sh
cpwd
```
Copies the current working directory path to the clipboard, making it easy to share or use in other commands.

#### ⭕ <a name="pas">Start Laravel Development Server</a>

```sh
pas
```
Starts the Laravel development server, allowing you to quickly test and preview your application.

#### ⭕ <a name="pa">Run PHP Artisan</a>

```sh
pa
```

Runs the PHP Artisan command-line tool for Laravel, providing a convenient way to manage and interact with your Laravel project.

#### ⭕ <a name="gpush">Push Git Changes with Message</a>

```sh
gpush <message>
```
Pushes local Git changes to the remote repository with a custom commit message, streamlining the Git workflow.

#### ⭕ <a name="touch">Create or Touch File, just like touch command in unix envirement</a>

```sh
touch <filename>
```
create file if not argument is provided then tmp.txt is created.

#### ⭕ <a name="phpserve">Start PHP built-in web server</a>

```sh
phpserve <port>
```
Start PHP built-in web server in the current folder, if port is not provided then default port is 8080

#### ⭕ <a name="pyserve">Start Python HTTP server</a>

```sh
pyserve <port>
```
Start Python built-in Http server in the current folder, if port is not provided then default port is 8080

#### ⭕ <a name="gt">Navigates to a specified folder based on partial name</a>

```sh
gt <some-folder>
```
The `gt` function searches for a folder whose name matches the specified partial name. If multiple matches are found, it prompts you to select one. Once a unique match is determined, it navigates directly to that folder.

Before Using `gt`:
Before using the `gt` function, it's recommended to run the Scane-Folders function. This function scans your user home directory and stores the paths of all subfolders in a file called folderPaths.txt. This file is used by the `gt` function to quickly locate folders based on partial names.

To update folder paths, run:

```sh
Scane-Folders
```

*Example:*

Suppose you want to navigate to a folder named "Documents" within your user directory, but you're not sure of the full path. You can simply use gt followed by the partial name:

```sh
gt Documents
```
If multiple folders with "Documents" in their names exist, `gt` will display them and prompt you to select the desired one. After selecting, you will be navigated to the chosen folder

#### ⭕ <a name="ex">Open current directory in File Explorer</a>

```sh
ex
```
Opens the current working directory in File Explorer

#### ⭕ <a name="b">Go one step back to prev directory.. its like `cd ..`</a>

```sh
b
```
Go back to the previous directory

#### ⭕ <a name="mkg">Create a directory and navigate to it</a>

```sh
mkg <directory-name>
```
Create a directory with provided name and navigates into it

#### ⭕ <a name="head">Display the first few lines of a file</a>

```sh
head <file-path> <lines-count>
```
Display the first few lines of a file, the number of line showed by default is 10.

#### ⭕ <a name="head">Display the last few lines of a file</a>

```sh
tail <file-path> <lines-count>
```
Display the last few lines of a file, the number of line showed by default is 10.

#### ⭕ <a name="dl">Download a file using BITS with resume support</a> 

```sh
df <file-url>
```


## Contribution Guidelines

1. Fork the repository and create a new branch for your feature or fix.
2. Write a clear and concise commit message describing your changes.
3. Open a pull request to merge your changes into the main branch.

## License

This repository is licensed under the MIT License.
