////
////  NewMessageView.swift
////  YoddChatGpt
////
////  Created by Ale on 27/01/23.
////
//
//import SwiftUI
//
//
///**
// This is the view of the TextField that manages also the sending and recieving of a message.
//
// - Version: 0.1
//
// */
//struct NewMessageView: View {
//    // MARK: - Environmental objects
//    @Environment(\.dismiss) var dismiss
//    @Environment (\.managedObjectContext) var managedObjectContext
//
//    // MARK: - Sending message properties
//    ///This is the text written in the textfield
//    @Binding var text : String
//    ///This is what manages the focus state of the keyboard
//    @FocusState var textIsFocused : Bool
//    ///Here are stored the messages sent and recieved alongside with CoreData
//    @State var models = [TemporaryMessage]()
//
//    // MARK: - ViewModels
//    var audioPlayer = AudioPlayer()
//    @ObservedObject var openAIViewModel = OpenAIViewModel()
//
//
//    var body: some View {
//    
//    
//
//struct NewMessageView_Previews: PreviewProvider {
//    @FocusState var textIsFocused : Bool
//    static var previews: some View {
//        ZStack {
//            NewMessageView(text: .constant("Text"))
//        }
//    }
//}
