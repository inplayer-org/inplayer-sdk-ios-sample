//
//  NSObjectExt.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/13/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import Foundation

extension NSObject: ClassNameProtocol {}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
