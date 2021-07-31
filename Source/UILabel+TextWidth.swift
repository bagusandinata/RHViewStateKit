//
//  UILabel+TextWidth.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import Foundation

public extension UILabel {
    var textWidth: CGFloat? {
        guard let myText = self.text else { return nil }
        guard let myFont = self.font else { return  nil }
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: myFont], context: nil)
        return ceil(labelSize.width)
    }
}
