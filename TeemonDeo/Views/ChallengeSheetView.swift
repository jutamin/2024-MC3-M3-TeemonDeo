//
//  ChallengeSheetView.swift
//  TeemonDeo
//
//  Created by TEO on 8/2/24.
//

import SwiftUI

struct ChallengeSheetView: View {
    @State var challengeTitle: String = ""
    @State var theDate: Date = Date()
    @State private var isExpanded = false

    private func selectCategory(){
        
        
    }
    
    
    
    var body: some View {
        VStack{
            HStack{
                Text("챌린지 추가") //LaundaryGothicOTF 18 Bold
                    .font(.laundryBold18)
                    .frame(height: 27)
                
                Spacer()
                
                Button{
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray800)
                }
            }
            .padding(10)
            .padding(4)

            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray100)
                    .frame(height: 61)
                
                TextField("챌린지 이름을 입력해주세요", text: $challengeTitle)
                    .foregroundColor(Color.gray400)
                    .font(.SuitTitle2)
                    .padding()
            }
            .padding(10)

            HStack{
                Text("시작일")
                    .font(.SuitTitle2)
                
                Spacer()
                
                DatePicker("korea", selection: $theDate, displayedComponents: .date)
                    .labelsHidden()
                // Wheel 스타일을 사용하려면 사이즈 커스텀이 필요하다
//                if isExpanded {
//                    DatePicker("", selection: $theDate, displayedComponents: [.date])
//                        .datePickerStyle(WheelDatePickerStyle())
//                        .frame(height: 200)
//                        .labelsHidden()
//                } else {
//                    Text(theDate, style: .date)
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(10)
//                }
            }
            .padding(10)
//            .onTapGesture {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }

            Divider()
                .padding(.horizontal, 10)

            HStack{
                Text("기간")
                    .font(.SuitTitle2)

                Spacer()
                
                Button{
                    
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding(10)

            Divider()
                .padding(.horizontal, 10)
            
            HStack{
                Text("청소 범위")
                    .font(.SuitTitle2)

                Spacer()
                
                Text("챌린지 기간동안 청소할 공간을 선택해주세요!")
                    .font(.SuitBody2)
                    .foregroundColor(.gray400)

            }
            .padding(10)
            
            HStack{

            }
            .padding(10)

        }
        .padding(10)

        
    }
}



struct selectCategoryView: View {
    @State var selected: Bool = false
    var item: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(selected ? Color.blue : Color.gray100)
                .frame(width: 52, height: 32)

            Text("\(item)")
                .font(selected ? .PretendardExtraBold16 : .SuitBody1)
                .foregroundColor(selected ? Color.white : Color.gray800)
        }
    }
}



#Preview {
    ChallengeSheetView()
}
