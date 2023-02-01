//
//  BotLoadingMessage.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI

struct BotLoadingMessage: View {
    
    @State var scale1 = 1.0
    @State var scale2 = 1.0
    @State var scale3 = 1.0

    @State var scale = 0.8

    var secondaryColor : Color

    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 5, height: 5)
                .scaleEffect(scale1)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)

                    withAnimation(repeated) {
                        scale1 = 0.5
                    }
                }
            
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 5, height:  5)
                .scaleEffect(scale2)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)

                    withAnimation(repeated) {
                        scale2 = 0.5
                    }
                }

            Circle()
                .foregroundColor(.secondary)
                .frame(width: 5, height: 5)
                .scaleEffect(scale3)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)

                    withAnimation(repeated) {
                        scale3 = 0.5
                    }
                }

            
            
            
        }
            .padding(.trailing, 30)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .padding(.leading, 5)
            .background {
                ZStack {
                    Rectangle().foregroundColor(secondaryColor)
                        .cornerRadius(20, corners: [.topRight, .bottomRight, .topLeft])
                        .padding(.trailing, 30).padding(.leading, 5)
                }
                
            }
            .scaleEffect(scale)
            .onAppear{
                let baseAnimation = Animation.easeIn(duration: 0.2)

                withAnimation(baseAnimation) {
                    scale = 1
                }
            }

    }
}

struct BotLoadingMessage_Previews: PreviewProvider {
    static var previews: some View {
        BotLoadingMessage( secondaryColor: .blue)
    }
}
