Homebrew packaging
==================

Install (from a tap)
--------------------
```bash
brew tap vertices-solutions/orbit
brew install orbit
```

Install a specific older series:
```bash
brew install orbit@0.1
```
Versioned formulae are keg-only; if you need them on PATH, use `brew link --force orbit@0.1`.

Start the daemon with Homebrew services (macOS + Linux):
```bash
brew services start orbit
```

Configuration
-------------
`orbitd` reads its config from the standard config directory:
- macOS: `~/Library/Application Support/orbitd/orbitd.toml`
- Linux: `~/.config/orbitd/orbitd.toml`

If `database_path` is not set, it defaults to:
- macOS: `~/Library/Application Support/orbitd/orbitd.sqlite`
- Linux: `~/.local/share/orbitd/orbitd.sqlite`

You can also run the daemon directly and point at a custom config:
```bash
orbitd --config /path/to/orbitd.toml
```
