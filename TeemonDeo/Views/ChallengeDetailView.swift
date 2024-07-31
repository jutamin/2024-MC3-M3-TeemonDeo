import SwiftUI

struct ChallengeDetailView: View {
    var body: some View {
        VStack {
            VStack {
                Text("책상부터 비워보자")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 7)
                Text("2024.07.21 ~ 2024.07.08")
                    .foregroundStyle(Color.gray)
                
            }
            .padding(.bottom, 20)
            
            HStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.lightSkyBlue)
                    .frame(width: 100, height: 35)
                    .overlay(
                        Text("1주 챌린지")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.darkSkyBlue)
                    )
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.lightGray)
                    .frame(width: 55, height: 35)
                    .overlay(
                        Text("책상")
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
                        Text("3일차 도전!")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.leading, 26)
                            .foregroundColor(Color.black)
                            
                        Spacer()
                        
                        Text("진행도 14%")
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

#Preview {
    ChallengeDetailView()
}
