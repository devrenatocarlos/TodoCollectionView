//
//  CircleButton.swift
//  HomeWorkToDo
//
//  Created by aluno on 12/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height/2
    }
}
