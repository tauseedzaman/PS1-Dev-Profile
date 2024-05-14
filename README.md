# PowerShell Profile For Developers

## Overview

This repository contains a collection of useful PowerShell functions and aliases for developers. The goal is to provide a starting point for developers to customize their PowerShell profiles and share their own contributions.

## Aliases

```sh
cpwd    
```

Copies the current working directory path to the clipboard.

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

## Contribution Guidelines

1. Fork the repository and create a new branch for your feature or fix.
2. Write a clear and concise commit message describing your changes.
3. Open a pull request to merge your changes into the main branch.

## License

This repository is licensed under the MIT License.
