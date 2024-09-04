//
//  Color.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
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
    static let gray600 = Color(hex: "#7C7B85")
    static let gray400 = Color(hex: "#A9AAB4")
    static let gray200 = Color(hex: "#DFE2E9")
    static let gray100 = Color(hex: "F6F8FA")
    
    static let imageTextBox = Color(hex: "#454545").opacity(0.7)

}


// MARK: 주차별 챌린지 컬러 팔레트
extension Color {
    static let DarkBlue = Color(hex: "#1BC2E6")
    static let Blue = Color(hex: "#00D1FF")
    static let LightBlue = Color(hex: "#00D1FF").opacity(0.2)
    static let SuperLightBlue = Color(hex: "#F2FDFF")
    
    static let DarkGreen = Color(hex: "#4DC542")
    static let Green = Color(hex: "#66E55B")
    static let LightGreeen = Color(hex: "#66E55B").opacity(0.2)
    
    static let DarkPink = Color(hex: "#F276D7")
    static let Pink = Color(hex: "#FE88E4")
    static let LightPink = Color(hex: "#FE88E4").opacity(0.2)
}
