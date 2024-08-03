import SwiftUI

// 데이터 모델을 정의하는 구조체
struct ChallengeModel: Identifiable {
    var id: String
    var challengeName: String
    var challengeStartDate: String // "yyyy.MM.dd" 형식의 날짜 문자열
    var challengePeriod: Int // 기간 (일 단위)
    var challengeSpace: String
    var isChallengeSucceed: Bool
    var challengePercent: Int
}

struct ChallengeDetailView: View {
    var challengeData: ChallengeModel
    
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
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.lightSkyBlue)
                    .frame(width: 100, height: 35)
                    .overlay(
                        Text("\(challengeData.challengePeriod)주 챌린지")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.darkSkyBlue)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.lightGray)
                    .frame(width: 55, height: 35)
                    .overlay(
                        Text(challengeData.challengeSpace)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.darkGray)
                    )
            }
            .padding(.bottom, 20)

            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.LightGray)
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
                            .foregroundColor(Color.darkGray)
                    }
                }
                .padding(.bottom, -4)

                Image("stamp")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -4)

                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 86)
                        .frame(maxWidth: .infinity)
                    
                    Text("오늘의 비움 실천하기")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 20)
                        .offset(y: -10)
                }
                .padding(.bottom, 0)
            }
            .ignoresSafeArea()

        }
        .padding(.top, 50)
        .navigationBarItems(trailing: Image("more"))
    }
}

extension Color {
    static let lightSkyBlue = Color(red: 0.70, green: 0.9, blue: 0.95)
    static let darkSkyBlue = Color(red: 0.12, green: 0.70, blue: 0.75)
    static let lightGray = Color(red: 0.8, green: 0.8, blue: 0.8)
    static let darkGray = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let LightGray = Color(red: 0.9, green: 0.9, blue: 0.9)
}

// 미리보기에서 사용하는 타입 수정
struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDetailView(challengeData: ChallengeModel(id: "1", challengeName: "책상부터 비워보자", challengeStartDate: "2024.07.31", challengePeriod: 1, challengeSpace: "책상", isChallengeSucceed: false, challengePercent: 14))
    }
}
