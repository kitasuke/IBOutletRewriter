# IBOutletRewriter

[![Swift 5.0](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat)](https://swift.org/download/)
[![Build Status](https://app.bitrise.io/app/422d74ce9ce2edf9/status.svg?token=LH-9c1ubBpW33I1Nk3b_Qw)](https://app.bitrise.io/app/422d74ce9ce2edf9)
[![codecov](https://codecov.io/gh/kitasuke/IBOutletRewriter/branch/master/graph/badge.svg)](https://codecov.io/gh/kitasuke/IBOutletRewriter)

## Overview

`@IBOutlet` code formatter using [SwiftSyntax](https://github.com/apple/swift-syntax).

## Requirements

Swift 5.0+  
Xcode 10.2+

## How to use

### Installation

Run below command

```terminal
$ make install
$ IBOutletRewriter help
```

### Available Commands

#### `dry-run --path <file-path>`

Dry-run for rewriting IBOutlet declaration

#### `help`

Display general or command-specific help

#### `run --path <file-path>`

Rewrite IBOutlet declaration

## Examples

### `private` as default

```diff
-@IBOutlet weak var button: UIButton!
+@IBOutlet private weak var button: UIButton!
```

### `weak` as default

```diff
-@IBOutlet private var button: UIButton!
+@IBOutlet private weak var button: UIButton!
```

### No `private(set)`

```diff
-@IBOutlet private(set) weak var button: UIButton!
+@IBOutlet private weak var button: UIButton!
```
## TODOs

- [ ] Support executing `run` to all files in directory
- [ ] Support yml file for customized configuration
- [ ] Better installation way

## Acknowledgements

- [SwiftRewriter](https://github.com/inamiy/SwiftRewriter)
- [swift-ast-explorer-playground](https://github.com/kishikawakatsumi/swift-ast-explorer-playground)
