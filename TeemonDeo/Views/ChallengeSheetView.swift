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
    @State private var isSelected: Int? = nil


    
    var body: some View {
        VStack{
            HStack{
                Text("챌린지 추가")
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
            }
            .padding(10)

            Divider()
                .padding(.horizontal, 10)

            HStack{
                Text("기간")
                    .font(.SuitTitle2)

                Spacer()
                
                challengePeriodText(period: 1, boxColor: .LightBlue, textColor: .DarkBlue)
//                    .contextMenu {
//                        Button {
//                            backgroundColor = .green
//                        } label: {
//                            Label("airtag", systemImage: "airtag.fill")
//                        }
//                        
//                        Button {
//                            backgroundColor = .cyan
//                        } label: {
//                            Label("applewatch", systemImage: "applewatch.watchface")
//                        }
//                        
//                        Button {
//                            backgroundColor = .pink
//                        } label: {
//                            HStack {
//                                Text("airpods")
//                                Image(systemName: "airpods.gen3")
//                            }
//                        }
//                    }
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
                SelectCategoryView(selected: isSelected == 1, item: "신발장")
                    .onTapGesture {
                        isSelected = (isSelected == 1) ? nil : 1
                    }
                SelectCategoryView(selected: isSelected == 2, item: "서랍")
                    .onTapGesture {
                        isSelected = (isSelected == 2) ? nil : 2
                    }
                SelectCategoryView(selected: isSelected == 3, item: "책상")
                    .onTapGesture {
                        isSelected = (isSelected == 3) ? nil : 3
                    }
                SelectCategoryView(selected: isSelected == 4, item: "옷장")
                    .onTapGesture {
                        isSelected = (isSelected == 4) ? nil : 4
                    }
                SelectCategoryView(selected: isSelected == 5, item: "화장대")
                    .onTapGesture {
                        isSelected = (isSelected == 5) ? nil : 5
                    }
            }
            .padding(10)

        }
        .padding(10)
    }
    
    func getPeriodColors(period: Int) -> (boxColor: Color, textColor: Color) {
        switch period {
        case 1:
            return (.periodBoxBlue, .periodTextBlue)
        case 2:
            return (.periodBoxGreen, .periodTextGreen)
        case 3:
            return (.periodBoxPink, .periodTextPink)
        default:
            return (.periodBoxBlue, .periodTextBlue)
        }
    }
    
    
}



struct SelectCategoryView: View {
    var selected: Bool
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


extension ChallengeSheetView {
    
    @ViewBuilder
    private func challengePeriodText(period: Int, boxColor: Color, textColor: Color) -> some View {
        Text("\(period)주 챌린지")
            .font(.SuitBody1)
            .foregroundColor(textColor)
            .padding(5)
            .padding(.horizontal, 5)
            .background(RoundedRectangle(cornerRadius: 8).fill(boxColor).frame(height: 32))
    }
}

#Preview {
    ChallengeSheetView()
}
