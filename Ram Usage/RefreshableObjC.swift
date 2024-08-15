//
//  RefreshableObjC.swift
//  Ram Usage
//
//  Created by Sergei Saliukov on 14/8/24.
//


//
//  Refreshable.swift
//  eul
//
//  Created by Gao Sun on 2020/6/29.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import Foundation

@objc protocol RefreshableObjC: AnyObject {
    func refresh()
}

protocol Refreshable: RefreshableObjC {
    func initObserver(for name: NSNotification.Name)
}

extension Refreshable {
    func initObserver(for name: NSNotification.Name) {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: name, object: nil)
    }
}
