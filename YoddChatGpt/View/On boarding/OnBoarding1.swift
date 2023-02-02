//
//  OnBoarding1.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI

struct OnBoarding1: View {
    
    @State var delay1 = false
    @State var delay2 = false
    @State var delay3 = false
    @State var delay4 = false
    
    @State var scale1 = 0.9
    @State var scale2 = 0.9
    @State var scale3 = 0.9
    @State var scale4 = 0.9



    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Yodd's ChatGPT")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                Text("Free and open-source mobile app using the OpenAISwift framework based on OpenAI's famous artificial intelligence.")
                    .fontWeight(.light)
                    .padding(.horizontal)
                    .padding(.top, 1)
            }
            VStack {
                if delay1 {
                    HStack {
                        Spacer()
                        HStack() {
                            Text("Hello ChatGPT, how are you?")
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 30)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .padding(.trailing, 5)
                        }.background {
                            ZStack {
                                Rectangle().foregroundColor(.blue)
                                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                                    .padding(.leading, 30).padding(.trailing, 5)
                            }
                        }
                        .scaleEffect(scale1)
                        .onAppear{
                            let baseAnimation = Animation.easeIn(duration: 0.2)
                            
                            withAnimation(baseAnimation) {
                                scale1 = 1
                            }
                        }
                        
                    }
                }
                if delay2 {
                    
                    HStack {
                    
                    Text("I'm fine, what about you?")
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 30)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .padding(.leading, 5)
                    
                    
                    
                        .background {
                            ZStack {
                                Rectangle()               .foregroundColor(.blue.opacity(0.8))
                                    .cornerRadius(20, corners: [.topRight, .bottomRight, .topLeft])
                                    .padding(.trailing, 30).padding(.leading, 5)
                            }
                        }
                        .scaleEffect(scale2)
                        .onAppear{
                            let baseAnimation = Animation.easeIn(duration: 0.2)
                            
                            withAnimation(baseAnimation) {
                                scale2 = 1
                            }
                        }
                        Spacer()
                        }
                }
                if delay3 {
                    HStack {
                        Spacer()
                        HStack() {
                            Text("Can you give me a lorem ipsum?")
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 30)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .padding(.trailing, 5)
                        }.background {
                            ZStack {
                                Rectangle().foregroundColor(.blue)
                                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                                    .padding(.leading, 30).padding(.trailing, 5)
                            }
                        }
                        .scaleEffect(scale3)
                        .onAppear{
                            let baseAnimation = Animation.easeIn(duration: 0.2)
                            
                            withAnimation(baseAnimation) {
                                scale3 = 1
                            }
                        }
                        
                    }
                }
                if delay4 {
                    
                    HStack {
                    
                    Text(" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer volutpat urna ante, id pretium libero ullamcorper et. Phasellus vehicula nisl sed consequat vehicula. Duis pellentesque nulla eget porttitor molestie. Morbi maximus nulla eu nisl suscipit, nec imperdiet odio ultricies. Donec non accumsan massa. Quisque quis dignissim lacus. Morbi viverra egestas augue, ac aliquet libero. Etiam ut odio et leo sodales placerat. Pellentesque nec ipsum eget eros cursus cursus a ac erat. Morbi ac convallis ipsum. Aenean venenatis aliquet est in vehicula. Sed dictum aliquet molestie.")
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 30)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .padding(.leading, 5)
                        .background {
                            ZStack {
                                Rectangle()               .foregroundColor(.blue.opacity(0.8))
                                    .cornerRadius(20, corners: [.topRight, .bottomRight, .topLeft])
                                    .padding(.trailing, 30).padding(.leading, 5)
                            }
                        }
                        .scaleEffect(scale4)
                        .onAppear{
                            let baseAnimation = Animation.easeIn(duration: 0.2)
                            
                            withAnimation(baseAnimation) {
                                scale4 = 1
                            }
                        }
                        Spacer()
                        }
                }


                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    delay1 = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    delay2 = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    delay3 = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    delay4 = true
                }
            }
        }
    }
}

struct OnBoarding1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding1()
    }
}
