//
//  ChallengeMainView.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//

import SwiftUI

struct ChallengeMainView: View {
    @ObservedObject var viewModel = ChallengeMainViewModel()
    @ObservedObject var challengeDetailViewModel = ChallengeDetailViewModel()
    @State var isShowingSheet = false
    @State var detents: PresentationDetent = .height(613)
    
    @State var path = NavigationPath()
    @State var recordscount: Int = 0
    
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
    
    func getUserTierImage(tier: Int) -> Image {
        switch tier {
        case 1 :
            return Image("tierLevel1")
        case 2 :
            return Image("tierLevel2")
        case 3 :
            return Image("tierLevel3")
        case 4 :
            return Image("tierLevel4")
        case 5 :
            return Image("tierLevel5")
        default:
            return Image("tierLevel1")
        }
    }
    
    var body: some View {
        
        NavigationStack(path: $path){
            VStack{
                HStack{
                    Text("복세단살")
                        .font(Font.laundryBold20)
                    
                    Spacer()
                    
                    //TODO: User의 Tire에 따른 이미지 변화
                    Text(getUserTierImage(tier: viewModel.challengeUser?.userTier ?? 1))
                        .font(.SuitBody1)
                        .foregroundStyle(Color.gray400)
                    Text(getUserTier(tier: viewModel.challengeUser?.userTier ?? 1))
                        .font(.SuitBody1)
                        .foregroundStyle(Color.gray400)
                }
                .padding()
                
                HStack{
                    Text("\(viewModel.challengeUser?.userNickname ?? "")님!\n오늘의 챌린지를\n시작해보세요!")
                        .font(.title)
                    
                    Spacer()
                    
                    Image("mainviewcharactor")
                        .resizable()
                        .frame(width: 150, height: 158)
                }
                .padding()
                
                //TODO: ProgressBar Status
                
                ScrollView{

                    HStack{
                        Text("진행 중인 챌린지")
                            .font(.laundryBold18)
                            .foregroundColor(.gray800)

                        Spacer()
                        
                        Button(action: {
                            isShowingSheet = true
                        }, label: {
                            addChallengeButton()
                        })
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                    .padding(.bottom, 8)
                    
                    ForEach(viewModel.challenges, id: \.self) { data in
                        NavigationLink(value: data, label: {
                            if DateHelper.calculateCurrentDay(startDate: data.challengeStartDate) <= data.challengePeriod*7 {
                                challengeCardView(challenge: data)
                            }
                            
                        })
                        NavigationLink(value: TimerData(challenge: data)) {
                            EmptyView()
                        }
                        NavigationLink(value: CertifyingData(challenge: data)) {
                            EmptyView()
                        }
                        NavigationLink(value: CertifyingFinishedData(challenge: data)) {
                            EmptyView()
                        }
                    }
                    .navigationDestination(for: Challenge.self) { challenge in
                        ChallengeDetailView(path: $path, challengeData: challenge)
                    }
                    .navigationDestination(for: TimerData.self) { timerData in
                        TimerView(path: $path, timerChalData: timerData)
                    }
                    .navigationDestination(for: CertifyingData.self) { certifyingData in
                        CertifyingView(path: $path, certiChalData: certifyingData)
                    }
                    .navigationDestination(for: CertifyingFinishedData.self) { certifyingFinishedData in
                        CertifyingFinishedView(path: $path, certFinlData: certifyingFinishedData)
                    }
                }
                .background(Color.gray100)
                .padding(.top, 20)
                
                
                
            }
            .navigationBarHidden(true)
            .refreshable {
                viewModel.loadChallenge()
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            ChallengeSheetView(viewModel: viewModel, isShowingSheet: $isShowingSheet)
                .ignoresSafeArea(.keyboard)
                .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(){
            viewModel.loadChallenge()
            viewModel.loadChallengerUser()
        }
    }
}


extension ChallengeMainView {
    @ViewBuilder
    private func addChallengeButton() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.black)
                .stroke(Color.gray200, lineWidth: 1)
                .frame(width: 112, height: 32)
            
            HStack{
                Text("챌린지 추가")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .foregroundColor(.white)
        }
    }
    
    
    @ViewBuilder
    private func challengePeriodText(period: Int, boxColor: Color, textColor: Color) -> some View {
        Text("\(period)주 챌린지")
            .font(.SuitArlert1)
            .foregroundColor(textColor)
            .padding(5)
            .background(Rectangle().fill(boxColor).frame(height: 23))
    }
    
    @ViewBuilder
    private func challengeSpaceText(space: String, boxColor: Color, textColor: Color) -> some View {
        Text("\(space)")
            .font(.SuitArlert1)
            .foregroundColor(textColor)
            .padding(5)
            .background(Rectangle().fill(boxColor).frame(height: 23))
    }
    
    
    @ViewBuilder
    private func challengeCardView(challenge: Challenge) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .stroke(Color.gray200, lineWidth: 1)
                .frame(maxWidth: .infinity)
                .frame(height: 94)
                .shadow(color: Color.black.opacity(0.05), radius: 20, y: 4)
            
            HStack{
                VStack(alignment: .leading){
                    Text("\(challenge.challengeName)")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(.top, 5)
                    
                    HStack{
                        challengePeriodText(period: challenge.challengePeriod, boxColor: getPeriodColors(period: challenge.challengePeriod).0, textColor: getPeriodColors(period: challenge.challengePeriod).1)
                        
                        challengeSpaceText(space: challenge.challengeSpace, boxColor: .gray200, textColor: .gray800)
                    }
                }
                .padding(.leading)
                
                Spacer()
                
                //TODO: Circle Custom Graph
                VStack{
                    PieChartView(data: addChartModel2(challenge: challenge))
                        .padding(.bottom, -10)
                    
                    Text("\(DateHelper.calculateProgress(startDate: challenge.challengeStartDate, period: challenge.challengePeriod))%")
                        .font(.SuitArlert1)
                        .foregroundStyle(Color.gray800)
                }
                .padding(.trailing)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        
    }
    
    @ViewBuilder
    private func CircularProgressView(challenge: Challenge) -> some View{
        ZStack {
            Circle()
                .stroke(
                    Color.gray200,
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: (Double(challengeDetailViewModel.recordCount) / Double(challenge.challengePeriod * 7) * 100))
                .stroke(
                    Color.LightBlue,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeIn, value: (Double(challengeDetailViewModel.recordCount) / Double(challenge.challengePeriod * 7) * 100))
        }.frame(maxWidth: 26, maxHeight: 26)
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
    
    func addChartModel2(challenge: Challenge) -> [challengeProgressChart] {
        return [challengeProgressChart(id: challenge.id,
                                                       challengeName: challenge.challengeName,
                                                       progress: DateHelper.calculateProgress(startDate: challenge.challengeStartDate, period: challenge.challengePeriod)),
                                challengeProgressChart(id: challenge.id,
                                                       challengeName: "default",
                                                       progress: 100 - DateHelper.calculateProgress(startDate: challenge.challengeStartDate, period: challenge.challengePeriod))
        ]
    }
}

#Preview {
    ChallengeMainView()
}
