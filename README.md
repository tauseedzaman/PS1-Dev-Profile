# PowerShell Profile For Developers

## Overview

This repository contains a collection of useful PowerShell functions and aliases for developers. The goal is to provide a starting point for developers to customize their PowerShell profiles and share their own contributions.

## Index

1. [cpwd](#cpwd)
2. [pas](#pas)
3. [pa](#pa)
4. [gpush](#gpush)

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

#### <a name="cpwd">Copy Working Directory Path</a>

```sh
cpwd
```
Copies the current working directory path to the clipboard, making it easy to share or use in other commands.

#### <a name="pas"></a>Start Laravel Development Server</a>

```sh
pas
```
Starts the Laravel development server, allowing you to quickly test and preview your application.

#### <a name="pa"></a>Run PHP Artisan</a>

```sh
pa
```

Runs the PHP Artisan command-line tool for Laravel, providing a convenient way to manage and interact with your Laravel project.

#### <a name="gpush"></a>Push Git Changes with Message

```sh
gpush <message>
```
Pushes local Git changes to the remote repository with a custom commit message, streamlining the Git workflow.


## Contribution Guidelines

1. Fork the repository and create a new branch for your feature or fix.
2. Write a clear and concise commit message describing your changes.
3. Open a pull request to merge your changes into the main branch.

## License

This repository is licensed under the MIT License.
