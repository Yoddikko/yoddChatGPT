/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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

    var secondaryColor: Color

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
                .frame(width: 5, height: 5)
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
