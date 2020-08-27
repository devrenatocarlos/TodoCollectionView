//
//  CircleImageView.swift
//  HomeWorkToDo
//
//  Created by aluno on 12/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import UIKit

final class CircleImageView : UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height/2
    }
    
}
