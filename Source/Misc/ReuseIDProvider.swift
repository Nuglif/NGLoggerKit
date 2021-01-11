//
//  ReuseIDProvider.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-04.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public protocol ReuseIDProvider {

    static var staticReuseID: String { get }
    var reuseID: String { get }
}

extension ReuseIDProvider {

    public static var staticReuseID: String { String(describing: type(of: self)) }
    public var reuseID: String { String(describing: type(of: self)) }
}
