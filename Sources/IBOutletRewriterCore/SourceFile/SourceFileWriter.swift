//
//  SourceFileParser.swift
//  IBOutletRewriterCore
//
//  Created by Yusuke Kita on 03/02/19.
//

import Foundation
import SwiftSyntax

public class SourceFileWriter {
    
    public let pathURL: URL
    
    public init(pathURL: URL) {
        self.pathURL = pathURL
    }
    
    public func write(_ sourceFileSyntax: Syntax) throws {
        try sourceFileSyntax.description.write(to: pathURL, atomically: true, encoding: .utf8)
    }
}
