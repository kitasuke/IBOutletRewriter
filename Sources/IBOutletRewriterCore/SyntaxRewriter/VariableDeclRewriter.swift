//
//  IBOutletRewriter.swift
//  IBOutletRewriterCore
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import SwiftSyntax

public class VariableDeclRewriter: SyntaxRewriter {
    
    override public func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        // ignore if no @IBOutlet
        guard let attributes = node.attributes,
            attributes.contains(where: { $0.attributeName.tokenKind == .IBOutletKind }) else {
                return super.visit(node)
        }
        
        guard let modifiers = node.modifiers else {
            return super.visit(node)
        }
        
        var newModifiers = replacingWithPrivateModifier(modifiers)
        newModifiers = appendingWeakModifier(to: newModifiers)
        
        let newNode = node.withModifiers(newModifiers)
        
        return super.visit(newNode)
    }
    
    private func replacingWithPrivateModifier(_ modifiers: ModifierListSyntax) -> ModifierListSyntax {
        var newModifiers = modifiers
        let privateModifier = DeclModifierSyntax { (builder) in
            builder.addToken(SyntaxFactory.makePrivateKeyword(leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
        }
        
        if let publicModifier = modifiers.first(where: { $0.name.tokenKind == .publicKeyword }) {
            newModifiers = modifiers.replacing(childAt: publicModifier.indexInParent, with: privateModifier)
        } else if let internalModifier = modifiers.first(where: { $0.name.tokenKind == .internalKeyword }) {
            newModifiers = modifiers.replacing(childAt: internalModifier.indexInParent, with: privateModifier)
        } else if let privateSetModifier = modifiers.first(where: { $0.name.tokenKind == .privateKeyword }), privateSetModifier.detail?.reduce(into: "", { result, token in result += token.text }) == "(set)" {
            newModifiers = modifiers.replacing(childAt: privateSetModifier.indexInParent, with: privateModifier)
        } else if modifiers.contains(where: { $0.name.tokenKind == .privateKeyword }) {
            return modifiers
        } else {
            newModifiers = modifiers.inserting(.init({ (builder) in
                builder.addToken(SyntaxFactory.makePrivateKeyword(leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
            }), at: 0)
        }
        return newModifiers
    }
    
    private func appendingWeakModifier(to modifiers: ModifierListSyntax) -> ModifierListSyntax {
        if modifiers.contains(where: { ContextualKeywordKind(rawValue: $0.name.text) == .weak }) {
            return modifiers
        }
        
        let weakModifier = DeclModifierSyntax { (builder) in
            builder.addToken(SyntaxFactory.makeIdentifier(ContextualKeywordKind.weak.rawValue, leadingTrivia: .noSpace, trailingTrivia: .oneSpace))
        }
        return modifiers.appending(weakModifier)
    }
}
