//
//  ChallengeMainView.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//

import SwiftUI

struct ChallengeMainView: View {
    @StateObject var viewModel = ChallengeMainViewModel()
    @State var isShowingSheet = false
    @State var detents: PresentationDetent = .height(613)
    
    
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    Text("복세단살")
                        .font(Font.laundryBold20)
                    
                    Spacer()
                    
                    //TODO: User의 Tire에 따른 이미지 변화
                    Text("개쩌는 티어")
                }
                .padding()
                
                HStack{
                    Text("\(viewModel.challengeUser?.userNickname ?? "")님!\n오늘의 챌린지를\n시작해보세요!")
                    //Text("쭈쭈님!\n오늘의 챌린지를\n시작해보세요!")
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
                    .padding(24)
                    .padding(.top)
                    
                    ForEach(viewModel.challenges) { data in
                        NavigationLink(destination: ChallengeDetailView(challengeData: data)) {
                            challengeCardView(challenge: data)
                        }
                    }
                    
                    
                }
                .background(Color.gray100)
                .padding(.top, 20)
                
                
                
            }
            .onAppear{
                viewModel.loadChallenge()
            }
            .refreshable {
                viewModel.loadChallenge()
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            ChallengeSheetView(viewModel: viewModel,isShowingSheet: $isShowingSheet)
                .ignoresSafeArea(.keyboard)
                .edgesIgnoringSafeArea(.bottom)
//                .presentationDetents([.height(geometry.size.height * 613.0 / 855.0)], selection: $detents)
//                .presentationDetents([.height(613)], selection: $detents)

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
                Image(systemName: "circle")
                    .padding(.trailing)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
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

#Preview {
    ChallengeMainView()
}
