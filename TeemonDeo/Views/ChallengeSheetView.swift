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
    @State private var challengePeriod: Int = 1
    
    
    var body: some View {
        VStack{
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
                .padding(.top, 10)
                .padding(.horizontal, 14)
                
                
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
                    
                    switch challengePeriod {
                    case 1:
                        challengePeriodText(period: 1, boxColor: .LightBlue, textColor: .DarkBlue)
                            .cornerRadius(8)
                    case 2:
                        challengePeriodText(period: 2, boxColor: .LightGreeen, textColor: .DarkGreen)
                            .cornerRadius(8)
                    case 3:
                        challengePeriodText(period: 3, boxColor: .LightPink, textColor: .DarkPink)
                            .cornerRadius(8)
                    default:
                        challengePeriodText(period: 1, boxColor: .LightBlue, textColor: .DarkBlue)
                            .cornerRadius(8)
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
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .padding(10)
            
            Spacer()
            
            Button(action: {  }) {
                VStack{
                    Text("생성하기")
                        .font(.SuitTitle2)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    //.padding(.top, geometry.safeAreaInsets.top)
                    // TODO: safeArea만큼 bottom 처리
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 86)
                .background(Rectangle().fill(.black))
            }
        }

    }
    
    func getPeriodColors(period: Int) -> (boxColor: Color, textColor: Color) {
        switch period {
        case 1:
            return (.LightBlue, .DarkBlue)
        case 2:
            return (.LightGreeen, .DarkGreen)
        case 3:
            return (.LightPink, .DarkPink)
        default:
            return (.LightBlue, .DarkBlue)
        }
    }
}



struct SelectCategoryView: View {
    var selected: Bool
    var item: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(selected ? Color.Blue : Color.gray100)
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
            .frame(height: 32)
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 8))   // .contentShape 위치에 따라서 모양 변화
            .background(boxColor.cornerRadius(8))
            .contextMenu {
                Button {
                    challengePeriod = 1
                } label: {
                    Text("1주 챌린지")
                }
                
                Button {
                    challengePeriod = 2
                } label: {
                    Text("2주 챌린지")
                }
                
                Button {
                    challengePeriod = 3
                } label: {
                    Text("3주 챌린지")
                }
                
            }
    }
}

#Preview {
    ChallengeSheetView()
}
