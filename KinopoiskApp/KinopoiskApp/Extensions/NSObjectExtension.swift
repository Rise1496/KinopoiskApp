//
//  NSObjectExtension.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

extension NSObject {
    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    public var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }

    static var nibName: String {
        return String(describing: self)
    }
}
