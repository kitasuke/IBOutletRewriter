//
//  Extensions.swift
//  SwiftOptimizerCore
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import SwiftSyntax

extension TokenKind {
    
    static var IBOutletKind: TokenKind {
        return .identifier(ContextualKeywordKind.IBOutlet.rawValue)
    }
}

extension Trivia {
    
    static var noSpace: Trivia {
        return .init(pieces: [])
    }
    
    static var oneSpace: Trivia {
        return .init(pieces: [.spaces(1)])
    }
}
