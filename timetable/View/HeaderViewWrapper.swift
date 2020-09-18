//
//  HeaderWrapperView.swift
//  timetable
//
//  Created by Roman Bukh on 9/18/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class HeaderViewWrapper: UIView {
    
    var viewModel: HeaderViewWrapperViewModelType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
