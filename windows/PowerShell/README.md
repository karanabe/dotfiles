# PowerShell profile

Copy or link `Microsoft.PowerShell_profile.ps1` to the profile path reported by
PowerShell:

```powershell
$PROFILE
```

The profile customizes the prompt and reports active uv virtual environments
through `$env:VIRTUAL_ENV`. It does not activate an environment or change the
working directory automatically.
