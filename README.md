# TyperTool
An example CLT using [Typer](https://github.com/Samasaur1/Typer)

## Installation

### [Homebrew](https://brew.sh)
```bash
brew install Samasaur1/core/typer
```

### [Mint](https://github.com/yonaskolb/mint)
```bash
mint install Samasaur1/TyperTool
```

### [Marathon](https://github.com/JohnSundell/Marathon)
```bash
marathon install https://raw.githubusercontent.com/Samasaur1/TyperTool/master/Sources/TyperTool/main.swift /usr/local/bin/typer
```

### Install Script
```bash
curl -fsSL https://raw.githubusercontent.com/Samasaur1/TyperTool/master/install.sh | bash
```

### Build From Source and Install
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

### Download and Install
1. Go to the [latest release](https://github.com/Samasaur1/TyperTool/releases/latest).
2. Click on the `.zip` file. (for example, `typer-1.0.0.zip`)
3. Open your `Downloads` folder in the Finder
4. Open another Finder window.
5. In that new window, use the `Go` menu and click `Go to folder...` (or press ⇧⌘G).
6. Type in `usr/local/bin` and click `Go`.
7. Drag the `typer` file in your `Downloads` folder into the new window.

### Notes
All of these methods work. However, only Homebrew, Mint, and Marathon can update TyperTool for you. Furthermore, **they all install to the same location, so only use one.**

Mint, Marathon, and Homebrew require tools to be installed, while the other options do not.

Mint, Marathon, and building from source require that Swift 4.0 or newer be installed, while the other options do not.

While unlikely, it is possible that Homebrew will take longer to make updates available than Mint or Marathon.

Here is the recommended order. Use the first option that you meet all the requirements for.
1. Homebrew
2. Mint / Marathon
3. Building from source
4. Install script / Download and install

## Usage

![Demo](https://github.com/Samasaur1/TyperTool/raw/master/typer-demo.gif)

Note: Due to this being online, this GIF has probably been slowed down. To view it at full speed, you can download the `.mov` version [here](https://github.com/Samasaur1/TyperTool/raw/master/typer-demo.mov).
