//
//  ChallengeOptionSheet.swift
//  TeemonDeo
//
//  Created by TEO on 8/7/24.
//


import SwiftUI

struct ChallengeOptionSheet: View {
    
    @Binding var isShowingOptionSheet: Bool

    var body: some View {
        VStack{
            HStack{
                Text("챌린지 설정")
                    .font(.SuitTitle2)
                
                Spacer()
                
                Button{
                    isShowingOptionSheet = false
                } label: {
                    Image(systemName: "xmark")

                }
            }
            .padding(.bottom, 30)
            
            Button {
                //
            } label: {
                HStack{
                    Image(systemName: "tray.fill")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .padding(.trailing, 5)

                    Text("버리기 인증 보관함")
                        .font(.SuitBody1)
                    
                    Spacer()
                }
                .foregroundColor(.black)

            }
            .padding(.bottom, 20)
            
            Button {
                //
            } label: {
                HStack{
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: 18, height: 22)
                        .padding(.trailing, 5)
                    Text("챌린지 삭제")
                        .font(.SuitBody1)

                    
                    Spacer()
                }
                .foregroundColor(.red)
            }
            .padding(.leading, 3)
        }
        .padding(.horizontal, 20)
        
    }
}

//#Preview {
//    ChallengeOptionSheet()
//}
