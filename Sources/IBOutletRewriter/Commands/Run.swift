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

struct RunCommand: CommandProtocol {
    
    typealias Options = RunOptions
    
    let verb = "run"
    let function = "Rewrite IBOutlet declaration"
    
    func run(_ options: RunOptions) -> Result<(), AnyError> {
        
        do {
            let pathURL = URL(fileURLWithPath: options.path)
            let parser = SourceFileParser(pathURL: pathURL)
            let syntax = try parser.parse()
            let modifiedSyntax = VariableDeclRewriter().visit(syntax)

            let writer = SourceFileWriter(pathURL: pathURL)
            try writer.write(modifiedSyntax)
            return .init(value: ())
        } catch let error {
            return .init(error: AnyError(error))
        }
    }
}

struct RunOptions: OptionsProtocol {
    
    typealias ClientError = AnyError
    
    fileprivate let path: String
    private init(path: String) {
        self.path = path
    }
    
    private static func create(_ path: String) -> RunOptions {
        return RunOptions(path: path)
    }

    static func evaluate(_ m: CommandMode) -> Result<RunOptions, CommandantError<ClientError>> {
        return create
            <*> m <| Option(key: "path", defaultValue: "", usage: "path to run IBOutletRewriter")
    }
}
