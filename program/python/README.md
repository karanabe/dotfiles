# Python

Python versions, project environments, and Python tools are managed with uv.

```shell
./install.sh
uv python install
uv venv
uv run python --version
./update.sh
```

The standalone uv executable is installed in `$HOME/.local/bin`. Managed
Python versions and tools use the locations configured in `.zshenv`.
