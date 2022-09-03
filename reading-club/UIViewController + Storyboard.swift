//
//  UIViewController + Storyboard.swift
//  reading-club
//
//  Created by Agata on 11.08.2022.
//

import Foundation
import UIKit

extension UIViewController { //универсальный тип - Т, ищет в нашем проекте файл сториборд, и если он есть, подгружает вью контроллер оттуда, а не откуда-то еще
    class func loadFromStoryboard<T:UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T{
            return viewController
        } else {
            fatalError("Error: no initial view controller in \(name) storyboard")
        }
    }
}
