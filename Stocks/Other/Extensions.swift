//
//  Extensions.swift
//  Stocks
//
//  Created by Yaroslav on 21.01.22.
//

import Foundation
import UIKit

//MARK: - DateFormatter

extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYy-MM-dd"
        return formatter
    }()
}

//MARK: - Add Subview

extension UIView {
    func addSubViews(_ views: UIView...){
        views.forEach {
            addSubview($0)
        }
    }
}

// MARK: - Framing

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        top + height
    }
}
