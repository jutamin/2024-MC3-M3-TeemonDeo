//
//  SettingProfileView.swift
//  TeemonDeo
//
//  Created by 김민정 on 8/2/24.
//

import SwiftUI

struct SettingProfileView: View {
    @State private var nickname: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("닉네임")
                        .font(.system(size: 18, weight: .bold))
                        .padding()
                        .padding(.bottom, -10)
                    
                    ZStack(alignment: .trailing) {
                        TextField("닉네임을 입력하세요", text: $nickname)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.9, green: 0.9, blue: 0.9)))
                            .onChange(of: nickname) { newValue in
                                if newValue.count > 10 {
                                    nickname = String(newValue.prefix(10))
                                }
                            }
                            .padding(.horizontal)
                        
                        Text("\(nickname.count)/10자")
                            .foregroundColor(.gray)
                            .padding(.trailing, 35)
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Button(action: {
                    // 버튼 클릭 시 실행될 코드
                    print("버튼이 클릭되었습니다.")
                }) {
                    Text("저장")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 65)
                        .background(nickname.isEmpty ? Color.gray : Color.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, -20)
                .padding(.leading, -20)
                .padding(.trailing, -20)
                .disabled(nickname.isEmpty)
            }
            .padding()
            .navigationTitle("프로필 수정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingProfileView()
    }
}

