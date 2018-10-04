//
//  ViewController.swift
//  RxTest
//
//  Created by Yura Granchenko on 10/4/18.
//  Copyright © 2018 Yura Granchenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RainbowSwift

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.rx.tap.asObservable().scan(self) { first, _ in
            print (">>self - \(first)<<")
            return first
            }.subscribe(onNext: { flag  in
                print (">>self - \(flag)<<")
            }).disposed(by: disposeBag)
        
        let numbers = [0, 1, 2 , 3, 4, 5, 6]
        
        numbers.scan([]) { lastSlice, newValue in
            return Array(lastSlice + [newValue]).suffix(3)
            }
            .subscribe {  value in
                print("last 3: \(value)" )
            }.disposed(by: disposeBag)
        
        
//        Observable<Int>.create { observer in
//            print(Thread.isMainThread)
//            observer.onNext(1)
//            sleep(1)
//            observer.onNext(2)
//            return Disposables.create()
//            }
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { _ in
//                print(Thread.isMainThread)
//            })

    }
}

