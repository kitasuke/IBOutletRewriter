//
//  Extensions.swift
//  IBOutletRewriterCore
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

extension SyntaxFactory {
    static func makePrivateModifier() -> DeclModifierSyntax {
        return .init { builder in
            builder.useName(SyntaxFactory.makePrivateKeyword(leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
        }
    }

    static func makeWeakModifier() -> DeclModifierSyntax {
        return .init { (builder) in
            builder.useName(SyntaxFactory.makeIdentifier(ContextualKeywordKind.weak.rawValue, leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
        }
    }
}

extension ModifierListSyntax {

    func replacingWithPrivateModifier() -> ModifierListSyntax {
        let privateModifier = SyntaxFactory.makePrivateModifier()

        if let publicModifier = self.first(where: { $0.name.tokenKind == .publicKeyword }) {
            // public -> private
            return self.replacing(childAt: publicModifier.indexInParent, with: privateModifier)
        } else if let internalModifier = self.first(where: { $0.name.tokenKind == .internalKeyword }) {
            // internal -> private
            return self.replacing(childAt: internalModifier.indexInParent, with: privateModifier)
        } else if let privateSetModifier = self.first(where: { $0.name.tokenKind == .privateKeyword }),
            privateSetModifier.detail?.text == "set" {
            // private(set) -> private
            return self.replacing(childAt: privateSetModifier.indexInParent, with: privateModifier)
        } else if self.contains(where: { [.privateKeyword, .fileprivateKeyword].contains($0.name.tokenKind) }) {
            // private
            return self
        } else {
            // -> private
            return self.inserting(privateModifier, at: 0)
        }
    }

    func appendingWeakModifier() -> ModifierListSyntax {
        guard self.first(where: { ContextualKeywordKind(rawValue: $0.name.text) == .weak }) == nil else {
            return self
        }

        let weakModifier = SyntaxFactory.makeWeakModifier()
        return self.appending(weakModifier)
    }
}
