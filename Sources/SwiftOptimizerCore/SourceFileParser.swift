//
//  SourceFileParser.swift
//  SwiftOptimizerCore
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftSyntax

public class SourceFileParser {
    
    public let path: String
    public var pathURL: URL {
        return URL(fileURLWithPath: path)
    }
    
    public init(path: String) {
        self.path = path
    }
    
    public func parse() throws -> SourceFileSyntax {
        return try SyntaxTreeParser.parse(pathURL)
    }
}
