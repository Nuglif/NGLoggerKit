//
//  ViewController.swift
//  LoggerKit_Sample
//
//  Created by Werck, Ayrton on 18-07-09.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import UIKit
import NGLoggerKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        logger.info(SampleCategory.audio, "Hello info")
        logger.error(SampleCategory.audio, "Hello error")
        logger.verbose(SampleCategory.audio, "Hello verbose")
        logger.warning(SampleCategory.audio, "Hello warning")
    }
}
