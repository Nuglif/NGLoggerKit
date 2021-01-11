//
//  AppDelegate.swift
//  LoggerKit_Sample
//
//  Created by Werck, Ayrton on 18-07-09.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import UIKit
import NGLoggerKit

let logger = LoggerBuilder().buildDefault(subSystem: "Sample")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
}
