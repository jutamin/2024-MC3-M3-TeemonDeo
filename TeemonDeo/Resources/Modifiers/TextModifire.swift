//
//  TextModifire.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//

import SwiftUI
import Foundation

/// 어떤 View에 대해 font와 foregroundColor를 적용하는 Modifier
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 30)
            .font(.body)
            .foregroundStyle(Color.certifyLabelText)
            .background(Color.certifyLabel)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        // Clipp shape 방법 조금 안좋은 것 같다
    }
}

/// 어떤 View에 대해 font와 foregroundColor를 적용하는 Modifier
struct CertifyCountModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 30)
            .font(.body)
            .foregroundStyle(Color.certifyLabelText)
            .background(Color.certifyLabel)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        // Clipp shape 방법 조금 안좋은 것 같다
    }
}



// TODO: 자간을 퍼센티지 % 로 조절할 수 있는 수정자
struct PercentageTracking: ViewModifier {
    let percentage: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: FontSizePreferenceKey.self, value: geometry.size.height)
                }
            )
            .onPreferenceChange(FontSizePreferenceKey.self) { fontSize in
                let trackingValue = fontSize * percentage / 100
                content.tracking(trackingValue)
            }
    }
}

struct FontSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func percentageTracking(_ percentage: CGFloat) -> some View {
        self.modifier(PercentageTracking(percentage: percentage))
    }
}

/// 사용 방법
//struct ContentView: View {
//    var body: some View {
//        Text("이거시 -2% 자간입니다")
//            .font(.system(size: 20))
//            .percentageTracking(-2)
//    }
//}
