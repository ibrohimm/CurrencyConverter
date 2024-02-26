//
//  GCDUtils.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

func inBackground(qos: DispatchQoS.QoSClass = .default, _ block: @escaping () -> ()) {
    DispatchQueue.global(qos: qos).async {
        block()
    }
}

func onMain(_ block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}
