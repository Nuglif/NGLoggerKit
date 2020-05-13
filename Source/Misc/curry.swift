//
//  curry.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-09.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

private func curry(_ fn: @escaping (LoggerLevel, LogCategoryProtocol, @escaping @autoclosure () -> String, LogDetails) -> Void) -> (LoggerLevel) -> (LogCategoryProtocol) -> (@escaping @autoclosure () -> String) -> (LogDetails) -> Void {
    return { level in
        return { categ in
            return { (closure: @escaping () -> String) in
                return { details in
                    fn(level, categ, closure(), details)
                }
            }
        }

    }
}
