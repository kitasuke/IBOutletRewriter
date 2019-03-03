//
//  SourceFileParser.swift
//  SwiftOptimizerCore
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftSyntax

public class SourceFileParser {
    
    public let pathURL: URL
    
    public init(arguments: [String]) throws {
        guard arguments.count > 1 else {
            throw SourceFileParserError.invalidInput
        }
        
        self.pathURL = URL(fileURLWithPath: arguments[1])
    }
    
    public func parse() throws -> SourceFileSyntax {
        return try SyntaxTreeParser.parse(pathURL)
    }
}
