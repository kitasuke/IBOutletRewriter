//
//  main.swift
//  SwiftOptimizer
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftOptimizerCore

do {
    let sourceFileParser = try SourceFileParser(arguments: CommandLine.arguments)
    let sourceFile = try sourceFileParser.parse()
    print(sourceFile)
} catch let error {
    print(error)
}
