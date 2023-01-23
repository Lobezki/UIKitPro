//
//  UITextFieldPro.swift
//  UIKitPro
//
//  Created by Кирилл Сурело on 20.02.2022.
//

import UIKit

class UITextFieldPro: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .redraw
//        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        sharedInit()
    }
}

