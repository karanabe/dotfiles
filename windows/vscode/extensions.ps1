# extensions.json file path
$EXTENSIONS_FILE = ".vscode/extensions/extensions.json"

# extensions.json exists
if (!(Test-Path $EXTENSIONS_FILE)) {
  Write-Host "extensions.json file not found: $EXTENSIONS_FILE"
  exit
}

# extensions.json get extensions id then install
(Get-Content $EXTENSIONS_FILE | ConvertFrom-Json) | ForEach-Object {
  $extensionId = $_.identifier.id
  if ($extensionId) {
    Write-Host "Extension install: $extensionId"
    code --install-extension $extensionId
  }
  else {
    Write-Host "Can not found extensions"
  }
}

Write-Host "Done."

