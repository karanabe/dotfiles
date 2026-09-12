#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true)]
param(
  [string]$ExtensionsFile = (Join-Path (Get-Location) '.vscode/extensions/extensions.json')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resolvedExtensionsFile = (Resolve-Path -LiteralPath $ExtensionsFile).Path
$codeCommand = Get-Command code -ErrorAction Stop
$extensions = @(Get-Content -LiteralPath $resolvedExtensionsFile -Raw | ConvertFrom-Json)

foreach ($extension in $extensions) {
  $identifierProperty = $extension.PSObject.Properties['identifier']
  $idProperty = if ($identifierProperty -and $null -ne $identifierProperty.Value) {
    $identifierProperty.Value.PSObject.Properties['id']
  }
  $extensionId = if ($idProperty) { $idProperty.Value } else { $null }
  if ([string]::IsNullOrWhiteSpace($extensionId)) {
    Write-Warning "Skipped an entry without an extension identifier in '$resolvedExtensionsFile'."
    continue
  }

  if ($PSCmdlet.ShouldProcess($extensionId, 'Install VS Code extension')) {
    Write-Host "Installing VS Code extension: $extensionId"
    & $codeCommand.Source --install-extension $extensionId
    if ($LASTEXITCODE -ne 0) {
      throw "VS Code extension installation failed for '$extensionId' with exit code $LASTEXITCODE."
    }
  }
}

Write-Host 'VS Code extension installation complete.'
