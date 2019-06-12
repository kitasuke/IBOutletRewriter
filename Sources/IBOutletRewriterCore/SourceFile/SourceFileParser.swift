//
//  SourceFileParser.swift
//  IBOutletRewriterCore
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftSyntax

public class SourceFileParser {
    
    public let pathURL: URL
    
    public init(pathURL: URL) {
        self.pathURL = pathURL
    }
    
    public func parse() throws -> SourceFileSyntax {
        return try SyntaxParser.parse(pathURL)
    }
}
