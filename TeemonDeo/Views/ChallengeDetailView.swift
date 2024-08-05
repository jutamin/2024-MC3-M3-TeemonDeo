

import SwiftUI


struct ChallengeDetailView: View {
    var challengeData: Challenge
    
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
    
    var body: some View {
        VStack {
            VStack {
                Text(challengeData.challengeName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 7)
                
                Text("\(challengeData.challengeStartDate) ~ \(DateHelper.calculateEndDate(startDate: challengeData.challengeStartDate, period: challengeData.challengePeriod))")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom, 20)
            
            HStack(spacing: 10) {
                challengePeriodText(period: challengeData.challengePeriod, boxColor: getPeriodColors(period: challengeData.challengePeriod).0, textColor: getPeriodColors(period: challengeData.challengePeriod).1)
                    .cornerRadius(8)

                challengeSpaceText(space: challengeData.challengeSpace, boxColor: .gray200, textColor: .gray800)
                    .cornerRadius(8)

            }
            .padding(.bottom, 20)

            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray100)
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                    
                    HStack {
                        let currentDay = DateHelper.calculateCurrentDay(startDate: challengeData.challengeStartDate)
                        Text("\(currentDay)일차 도전!")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.leading, 26)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        let progress = DateHelper.calculateProgress(startDate: challengeData.challengeStartDate, period: challengeData.challengePeriod)
                        Text("진행도 \(progress)%")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.trailing, 26)
                            .foregroundColor(Color.gray600)
                    }
                }
                .padding(.bottom, -4)
                
                Image("stamp")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -4)
                
                
                NavigationLink {
                    TimerView(timerChalData: challengeData)
                } label: {
                    VStack{
                        Text("오늘의 비움 실천하기")
                            .font(.SuitTitle2)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 86)
                    .background(Rectangle().fill(.black))
                }

            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .padding(.top, 50)
        .navigationBarItems(trailing: 
                                Button(action: {
            //
        }, label: {
            Image(systemName: "ellipsis")
        })
        )
    }
}


extension ChallengeDetailView {

    @ViewBuilder
    private func challengePeriodText(period: Int, boxColor: Color, textColor: Color) -> some View {
        Text("\(period)주 챌린지")
            .font(.PretendardSemiBold14)
            .foregroundColor(textColor)
            .padding(5)
            .padding(.horizontal, 5)
            .background(Rectangle().fill(boxColor))
    }
    
    @ViewBuilder
    private func challengeSpaceText(space: String, boxColor: Color, textColor: Color) -> some View {
        Text("\(space)")
            .font(.PretendardSemiBold14)
            .foregroundColor(textColor)
            .padding(5)
            .padding(.horizontal, 5)
            .background(Rectangle().fill(boxColor))
    }
    
}


// 미리보기에서 사용하는 타입 수정
//struct ChallengeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeDetailView(challengeData)
//    }
//}
    
