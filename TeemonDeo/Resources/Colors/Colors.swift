//
//  Colors.swift
//  TeemonDeo
//
//  Created by TEO on 7/31/24.
//

import SwiftUI
import Foundation

extension Color {
        
    // Hexcode로 색상을 넣고 싶을 땐 이렇게 새로운 생성자를 선언하여 Color("#000000")과 같은 방식으로 사용합니다.
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}


extension Color {
    static let certifyLabel = Color(hex: "#A8EFFF")
    static let certifyLabelText = Color(hex: "#454545")
    
    static let cameraButtonStroke = Color(hex: "#292C2C")
    static let gray800 = Color(hex: "#292C2C")

    
    static let mainBlue = Color(hex: "#00D1FF")
    
    
}
