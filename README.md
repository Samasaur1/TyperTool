# TyperTool
An example CLT using [Typer](https://github.com/Samasaur1/Typer)

## Installation

### [Homebrew](https://brew.sh)
```bash
brew install Samasaur1/core/typer
```

### [Mint](https://github.com/yonaskolb/mint)
```bash
mint install github_name/repo_name
```

### [Marathon](https://github.com/JohnSundell/Marathon)
```bash
marathon install https://raw.githubusercontent.com/Samasaur1/TyperTool/master/Sources/TyperTool/main.swift /usr/local/bin/typer
```

### Install Script
```bash
curl -fsSL https://raw.githubusercontent.com/Samasaur1/TyperTool/master/install.sh | bash
```

### Build From Source
```bash
git clone https://github.com/Samasaur1/TyperTool.git
cd TyperTool
swift build -c release -Xswiftc -static-stdlib
cp .build/release/typer /usr/local/bin/typer
```
Optional (if you want to remove the source code):
```bash
cd ..
rm -rf TyperTool
```

While all of these methods will work, they will overlap, so only use one.

Mint and Marathon require that Swift 4.0 or greater be installed, but they will by nature be supported *instantaneously* as new versions come out.

Building from source requires Swift 4.0 or newer, but (obviously) is the latest version. However, this means that it *may* not be as stable as using an installer. On the other hand, code on `master` *should* always be working.

The install script does not require anything beyond what comes with macOS, and is instantaneous. If you don't have any of the prerequisites, this is the way to go

Homebrew does not require anything, but there may be some time until newer versions are available on it.
