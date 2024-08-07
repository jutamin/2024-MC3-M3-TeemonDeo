//
//  SettingView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import SwiftUI

struct SettingView: View {

    @Binding var showSignInView: Bool
    @StateObject private var settingViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("관리")
                        .font(Font.laundryBold20)
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingInfoView(showSignInView: $showSignInView),
                                   label:{
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.black)
                    })
                }
                .padding()
                        
                profileView()
                    .padding(8)
                ScrollView{
                    endedChallengeListView()
                }.background(Color.gray100)
            }
        }
    }
}

struct profileView: View {
    @StateObject private var settingViewModel = SettingsViewModel()
    func getUserTier(tier: Int) -> String {
        switch tier {
        case 1 :
            return "기안84"
        case 2 :
            return "기테무"
        case 3 :
            return "서장훈"
        case 4 :
            return "브라이언"
        case 5 :
            return "곤도 마리에"
        default:
            return " "
        }
    }

    var body: some View {
        
        VStack() {
            NavigationLink(destination: SettingProfileView(),
                           label: {Image("defaultProfileImage")
                    .resizable()
                .frame(maxWidth: 80, maxHeight: 80)})
            .padding(.bottom, 14)
            
            Text(settingViewModel.challengeUser?.userNickname ?? "유저닉네임")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            NavigationLink(destination: TierInfoView(),
                           label: {
                HStack{
                    Text(Image(systemName: "seal.fill"))
                        .font(.SuitBody2)
                        .foregroundStyle(Color.gray800)
                    Text(getUserTier(tier: settingViewModel.challengeUser?.userTier ?? 0))
                        .font(.SuitBody1)
                        .foregroundStyle(Color.gray800)
                    Text(Image(systemName: "questionmark.circle.fill"))
                        .font(.SuitBody2)
                        .foregroundStyle(Color.gray200)
                }
            })
            
        }
        .padding(.horizontal)
        .onAppear(){
            Task { await settingViewModel.loadChallengeUser2()
            }
        }
    }
}

struct endedChallengeListView: View {
    @StateObject var mainViewModel = ChallengeMainViewModel()

    var body: some View {
        VStack{
            HStack{
                Text("지난 챌린지")
                    .font(.laundryBold20)
                    .fontWeight(.bold)
                Spacer()
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 10, height: 10)
                    .foregroundStyle(Color.Blue)
                
                Text("\(String(mainViewModel.completedChallengeCount)) 완료")
                    .font(.callout)
                    .foregroundStyle(Color.Blue)
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 10, height: 10)
                    .foregroundStyle(Color.gray400)
                Text("\(String(mainViewModel.countChallenge() - mainViewModel.completedChallengeCount)) 미완료")
                    .font(.callout)
                    .foregroundStyle(Color.gray400)
                
            }
            .padding(.top, 28)
            .padding(.horizontal,20)
            
            ForEach(mainViewModel.challenges) { chall in
                if DateHelper.calculateCurrentDay(startDate: chall.challengeStartDate) > chall.challengePeriod*7 {
                    NavigationLink(destination: EndedChallengeDetailView(challengeData: chall)) {
                        endedChallengeListCell(challenge: chall)
                            .padding(.horizontal)
                    }
                }

            }
            Spacer()
        }
        .onAppear(){
            mainViewModel.loadChallenge()
        }
    }
}

struct endedChallengeListCell: View {
    var challenge: Challenge
    
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
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .stroke(Color.gray200, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: 120)
                .shadow(color: Color.black.opacity(0.05), radius: 20, y: 4)
            
            HStack{
                VStack(alignment: .leading, spacing: 8) {
                    Text(challenge.challengeName)
                        .font(.SuitTitle3)
                        .foregroundStyle(Color.black)
                    
                    Text("\(challenge.challengeStartDate) ~ \(DateHelper.calculateEndDate(startDate: challenge.challengeStartDate, period: challenge.challengePeriod))")
                        .font(.SuitArlert1)
                        .foregroundStyle(Color.gray400)
                    
                    HStack{
                        challengePeriodText(period: challenge.challengePeriod, boxColor: getPeriodColors(period: challenge.challengePeriod).0, textColor: getPeriodColors(period: challenge.challengePeriod).1)
                        
                        challengeSpaceText(space: challenge.challengeSpace, boxColor: .gray200, textColor: .gray800)
                    }
                }
                Spacer()
                Image(challenge.isChallengeSucceed ? "challengeCompleted" : "challengeNotCompleted")
                    .resizable()
                    .frame(maxWidth: 52, maxHeight: 52)
            }
            .padding()
        }
        
    }
    
    @ViewBuilder
    private func challengePeriodText(period: Int, boxColor: Color, textColor: Color) -> some View {
        Text("\(period)주 챌린지")
            .font(.footnote)
            .foregroundColor(textColor)
            .padding(5)
            .background(Rectangle().fill(boxColor).frame(height: 23))
    }
    
    @ViewBuilder
    private func challengeSpaceText(space: String, boxColor: Color, textColor: Color) -> some View {
        Text("\(space)")
            .font(.footnote)
            .foregroundColor(textColor)
            .padding(5)
            .background(Rectangle().fill(boxColor).frame(height: 23))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingView(showSignInView: .constant(false))
        }
    }
}
