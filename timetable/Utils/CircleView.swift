//
//  CircleView.swift
//  timetable
//
//  Created by Roman Bukh on 9/24/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class CircleView: UIView {
    
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = bounds.height / 2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
