//
//  ChallengeMainView.swift
//  TeemonDeo
//
//  Created by TEO on 7/31/24.
//

import SwiftUI

struct ChallengeMainView: View {
    @StateObject private var viewModel = ChallengeMainViewModel()

    var body: some View {
        NavigationStack{
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
                    //Text("\(viewModel.challengeUser)님!\n오늘의 챌린지를\n시작해보세요!")
                    Text("쭈쭈님!\n오늘의 챌린지를\n시작해보세요!")
                        .font(.title)
                    
                    Spacer()

                    Image("mainviewcharactor")
                        .resizable()
                        .frame(width: 150, height: 158)
                }
                .padding()

                //TODO: ProgressBar Status
                
                HStack{
                    Text("진행 중인 챌린지")
                        .font(.laundryBold18)
                    
                    Spacer()
                    
                    Button(action: {  }, label: {
                        Text("챌린지 추가")
                    })
                    
                }
                .padding()

//                ScrollView{
//                    ForEach(viewModel.challenges) { challenge in
//                    Naviga
//                        
//                    }
//                    
//                }
                
                
            }

        }
        
    }
}

#Preview {
    ChallengeMainView()
}


extension ChallengeMainView {
    @ViewBuilder
    private func afterCaptureView() -> some View {
        HStack(alignment: .center) {
           
        }
    }
    
    
    @ViewBuilder
    private func challengeCardView() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
            
            HStack{
                VStack{
                    
                    
                    HStack{
                        
                    }
                }
                
                Spacer()
                
                //TODO: Circle Custom Graph
                Image(systemName: "circle")
                
            }
        }
    }
}
