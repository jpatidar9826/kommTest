import SwiftUI
import Foundation
import Kommunicate
internal import KommunicateCore_iOS_SDK


struct ContentView: View {
    
    func getTopViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else {
            return nil
        }

        var top = root
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
    
    // OPEN LIST
    func openChatList() {
        if let vc = getTopViewController() {
            Kommunicate.showConversations(from: vc)
        }
    }
    
    // CHAT WITH USER
    func chatWithUser() {
        guard let vc = getTopViewController() else { return }

        let conversation = KMConversationBuilder()
            .withClientConversationId("unique_thread_for_target_user")
            .build()

        Kommunicate.createConversation(conversation: conversation) { response in
            switch response {
            case .success(let conversationId):
                DispatchQueue.main.async {
                    Kommunicate.showConversationWith(groupId: conversationId, from: vc) { success in
                        if !success {
                            print("Failed to show the conversation UI.")
                        }
                    }
                }
            case .failure(let error):
                print("Error creating or fetching conversation: \(error)")
            }
        }
    }
    
    // START NEW
    func startNewChat() {
        if let vc = getTopViewController() {
            Kommunicate.createAndShowConversation(from: vc) { error in
                if let error = error {
                    print("Error starting new chat: \(error)")
                }
            }
        }
    }

    var body: some View {
        VStack(spacing: 20) {

            Button("Open Chat List") {
                openChatList()
            }
            .buttonStyle(.bordered)

            Button("Chat with User (Resume/Create)") {
                chatWithUser()
            }
            .buttonStyle(.borderedProminent)

            Button("Start New Chat") {
                startNewChat()
            }
            .buttonStyle(.bordered)

        }
        .padding()
        .onAppear {
            KommunicateService.shared.login()
        }
    }
}
