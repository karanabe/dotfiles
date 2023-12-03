function parse_git_branch {
  git branch 2>$null |
  ForEach-Object {
    if($_[0] -eq "*") { ($_ -Split " ")[1] }
  }
}

function prompt () {
  (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell " + $pwd
  Write-Host $($env:USERNAME) -NoNewline -ForegroundColor Cyan
  Write-Host " at " -NoNewline
  Write-Host $($env:COMPUTERNAME) -NoNewline -ForegroundColor Magenta
  Write-Host " in " -NoNewline
  Write-Host (Split-Path (Get-Location) -Leaf) -NoNewline -ForegroundColor Yellow
  Write-Host " on " -NoNewline
  Write-Host "(" -NoNewline -ForegroundColor Green
  $PY_ENV = ($env:VIRTUAL_ENV -Split "\\")[-1]
  Write-Host ($PY_ENV -Split "/")[0] -NoNewline -ForegroundColor Green
  $GIT_BRANCH = (parse_git_branch)
  if ( $GIT_BRANCH ){
    Write-Host /$($GIT_BRANCH) -NoNewline -ForegroundColor Green
  }
  Write-Host ")" -NoNewline -ForegroundColor Green
  Write-Host " >" -NoNewline -ForegroundColor Red
  Write-Host ">" -NoNewline -ForegroundColor Yellow
  Write-Host ">" -NoNewline -ForegroundColor Green
  return " "
}
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1
Invoke-Expression "$env:USERPROFILE\venv\dev\Scripts\Activate.ps1"
Set-Location "$env:USERPROFILE"
