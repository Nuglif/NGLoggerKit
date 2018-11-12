//
//  ViewController.swift
//  LoggerKit_Sample
//
//  Created by Werck, Ayrton on 18-07-09.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import UIKit
import LoggerKit
import RxSwift
import RxCocoa
import NGTools

final class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Several example on how to call it
        _ = Observable<Int>.interval(2.0, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .do(onNext: { _ in
                switch arc4random_uniform(5) {
                case 1: logger.filter = FilterLevel(minLevel: .info, isStrict: true)
                case 2: logger.filter = FilterLevel(minLevel: .error, isStrict: true)
                case 3: logger.filter = FilterLevel(minLevel: .verbose, isStrict: true)
                case 4: logger.filter = FilterLevel(minLevel: .none, isStrict: true)
                default: logger.filter = FilterLevel(minLevel: .warning, isStrict: true)
                }
            })
            .subscribe(onNext: { (_) in
                let str = "⚡️: \(Thread.current) " + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")"
                logger.log(category: SampleCategory.audio, message: str)
            })
    }
}
