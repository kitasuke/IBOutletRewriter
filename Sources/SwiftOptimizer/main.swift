//
//  main.swift
//  SwiftOptimizer
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftOptimizerCore

let sourceFileParser = SourceFileParser(path: CommandLine.arguments[1])
do {
    let sourceFile = try sourceFileParser.parse()
    print(sourceFile)
} catch let error {
    print(error)
}
