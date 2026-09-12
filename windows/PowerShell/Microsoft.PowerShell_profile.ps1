function Get-GitBranch {
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    return
  }

  $branch = git branch --show-current 2>$null
  if ($LASTEXITCODE -eq 0) {
    $branch
  }
}

function Write-PromptSegment {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Text,

    [Parameter(Mandatory = $true)]
    [ConsoleColor]$Color
  )

  Write-Host $Text -NoNewline -ForegroundColor $Color
}

function prompt {
  $location = Get-Location
  (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell $location"

  Write-PromptSegment -Text $env:USERNAME -Color Cyan
  Write-Host ' at ' -NoNewline
  Write-PromptSegment -Text $env:COMPUTERNAME -Color Magenta
  Write-Host ' in ' -NoNewline
  Write-PromptSegment -Text (Split-Path $location -Leaf) -Color Yellow

  $context = @()
  if ($env:VIRTUAL_ENV) {
    $context += Split-Path $env:VIRTUAL_ENV -Leaf
  }
  $branch = Get-GitBranch
  if ($branch) {
    $context += $branch
  }
  if ($context.Count -gt 0) {
    Write-Host ' on ' -NoNewline
    Write-PromptSegment -Text ('({0})' -f ($context -join '/')) -Color Green
  }

  Write-PromptSegment -Text ' >' -Color Red
  Write-PromptSegment -Text '>' -Color Yellow
  Write-PromptSegment -Text '>' -Color Green
  return ' '
}

$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1
