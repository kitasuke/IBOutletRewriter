//
//  Run.swift
//  IBOutletRewriter
//
//  Created by Yusuke Kita on 03/03/19.
//

import Foundation
import Commandant
import Result
import IBOutletRewriterCore

struct DryRunCommand: CommandProtocol {
    
    typealias Options = DryRunOptions
    
    let verb = "dry-run"
    let function = "Dry-run for rewriting IBOutlet declaration"
    
    func run(_ options: DryRunOptions) -> Result<(), AnyError> {
        
        do {
            let sourceFileParser = SourceFileParser(pathURL: URL(fileURLWithPath: options.path))
            let sourceFileSyntax = try sourceFileParser.parse()
            let modifiedSourceFileSyntax = VariableDeclRewriter().visit(sourceFileSyntax)
            print(modifiedSourceFileSyntax)
            return .init(value: ())
        } catch let error {
            return .init(error: AnyError(error))
        }
    }
}

struct DryRunOptions: OptionsProtocol {
    
    typealias ClientError = AnyError
    
    fileprivate let path: String
    private init(path: String) {
        self.path = path
    }
    
    private static func create(_ path: String) -> DryRunOptions {
        return DryRunOptions(path: path)
    }

    static func evaluate(_ m: CommandMode) -> Result<DryRunOptions, CommandantError<ClientError>> {
        return create
            <*> m <| Option(key: "path", defaultValue: "", usage: "path to dry-run IBOutletRewriter")
    }
}
