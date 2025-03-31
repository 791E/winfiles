# Override the default colors to match nord theme
Set-PSReadLineOption -Colors @{
	InlinePrediction = '#b48ead'
	Parameter = '#8fbcbb'
	String = '#a3be8c'
	Command = '#88c0d0'
}

# Aliases
Set-Alias lsa "lsd -AF1"
Set-Alias lst "lsd -AF --tree --ignore-glob .git"
Set-Alias paste Get-Clipboard

# Unix-like rm flags
function rm {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    $Path = $Args[-1]
    $removeParams = @{}

    if ($Args -contains "-f") { $removeParams["Force"] = $true }
    if ($Args -contains "-r" -or $Args -contains "-R") { $removeParams["Recurse"] = $true }
    if ($Args -contains "-v") { $removeParams["Verbose"] = $true }
    if ($Args -contains "-d") { 
        if (-not (Test-Path $Path -PathType Container)) {
            Write-Error "-d flag requires a directory, but '$Path' is not a directory"
            return
        }
        if ((Get-ChildItem -Path $Path).Count -gt 0) {
            Write-Error "-d flag requires the directory to be empty, but '$Path' is not empty"
            return
        }
    }
    
    if ($Args -contains "-i") {
        $confirmation = Read-Host "Are you sure you want to remove '$Path'? (y/n)"
        if ($confirmation -ne 'y') {
            Write-Output "Skipped: $Path"
            return
        }
    }

    try {
        Remove-Item @removeParams -Path $Path -ErrorAction Stop
    } catch {
        Write-Error "Failed to remove $Path: $_"
    }
}


# Function to create a new directory and directly switch to it
function cnd([string]$name)
{
	mkdir $name
	Set-Location $name
}

# Function to list folder contents and sort them by date
function lst{
	param (
		[string]$Folder = "."
	)
	Get-ChildItem -Path $Folder | Sort-Object -Property CreationTime -Descending
}

# Function to create a symlink to a certain directory
function symlink {
	param (
		[Parameter(Mandatory=$true)]
		[string]$source,
		[Parameter(Mandatory=$true)]
		[string]$destination
	)
	sudo cmd /c mklink /d "$source" "$destination"
}

# Function to fuzzily find files and preview them with live coloring through bat
function ff {
	fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
}

# Function to activate a venv more comfortably
function activate {
    $activatePath = ".\.venv\Scripts\activate"
    
    if (Test-Path $activatePath) {
        . $activatePath
    } else {
        Write-Error "No virtual environment found at .\.venv\Scripts\activate"
    }
}

# Function to go back the specified number of directoy levels
function b {
    param (
        [int]$levels
    )

    # Start from the current directory
    $path = Get-Location

    # Iterate to go up 'levels' number of directories
    for ($i = 0; $i -lt $levels; $i++) {
        $path = Split-Path -Path $path -Parent
    }

    # Set the new location
    Set-Location -Path $path
}
