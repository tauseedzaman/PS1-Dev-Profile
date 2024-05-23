# PowerShell Profile For Developers

## Overview

This repository contains a collection of useful PowerShell functions and aliases for developers. The goal is to provide a starting point for developers to customize their PowerShell profiles and share their own contributions.

## Index

1. [cpwd](#cpwd)
2. [pas](#pas)
3. [pa](#pa)
4. [gpush](#gpush)
5. [touch](#touch)
6. [phpserver](#phpserver)
7. [pyserver](#pyserver)

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

#### 💻<a name="cpwd">Copy Working Directory Path</a>

```sh
cpwd
```
Copies the current working directory path to the clipboard, making it easy to share or use in other commands.

#### 💻<a name="pas"></a>Start Laravel Development Server</a>

```sh
pas
```
Starts the Laravel development server, allowing you to quickly test and preview your application.

#### 💻<a name="pa"></a>Run PHP Artisan</a>

```sh
pa
```

Runs the PHP Artisan command-line tool for Laravel, providing a convenient way to manage and interact with your Laravel project.

#### 💻<a name="gpush"></a>Push Git Changes with Message

```sh
gpush <message>
```
Pushes local Git changes to the remote repository with a custom commit message, streamlining the Git workflow.

#### 💻<a name="touch"></a>Create or Touch File, just like touch command in unix envirement

```sh
touch <filename>
```
create file if not argument is provided then temp.txt is created.

#### 💻<a name="phpserver"></a>Start PHP built-in web server

```sh
phpserver <port>
```
Start PHP built-in web server in the current folder, if port is not provided then default port is 8080

#### 💻<a name="pyserver"></a>Start Python HTTP server

```sh
pyserver <port>
```
Start Python built-in Http server in the current folder, if port is not provided then default port is 8080


## Contribution Guidelines

1. Fork the repository and create a new branch for your feature or fix.
2. Write a clear and concise commit message describing your changes.
3. Open a pull request to merge your changes into the main branch.

## License

This repository is licensed under the MIT License.
