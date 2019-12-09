//
//  LoggerKitSampleCategory.swift
//  LoggerKit_Sample
//
//  Created by Werck, Ayrton on 18-07-12.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation
import NGLoggerKit

@objc class SampleObjcCategory: NSObject {

    @objc static let VIDEO: String = SampleCategory.video.name
    @objc static let AUDIO: String = SampleCategory.audio.name

}

enum SampleCategory: LogCategoryProtocol {
    case video, audio

    var name: String {
        return String(describing: self).capitalized
    }
}
