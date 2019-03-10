# IBOutletRewriter

[![Swift 4.2](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://swift.org/download/)
[![Build Status](https://app.bitrise.io/app/422d74ce9ce2edf9/status.svg?token=LH-9c1ubBpW33I1Nk3b_Qw)](https://app.bitrise.io/app/422d74ce9ce2edf9)
[![codecov](https://codecov.io/gh/kitasuke/IBOutletRewriter/branch/master/graph/badge.svg)](https://codecov.io/gh/kitasuke/IBOutletRewriter)

## Overview

`@IBOutlet` code formatter using [SwiftSyntax](https://github.com/apple/swift-syntax).

## Requirements

Swift 4.2+  
Xcode 10+

## How to use

### Installation

Run below command and `IBOutletRewriter` binary will be generated under `.build/release/` directory

```terminal
$ swift build -c release
```

### Available Commands

#### `dry-run`

Dry-run for rewriting IBOutlet declaration

#### `help`

Display general or command-specific help

#### `run`

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

- [] Support yml file for customized configuration

## Acknowledgement

- [SwiftRewriter](https://github.com/inamiy/SwiftRewriter)
- [swift-ast-explorer-playground](https://github.com/kishikawakatsumi/swift-ast-explorer-playground)
