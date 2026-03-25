import Foundation
import Kommunicate
internal import KommunicateCore_iOS_SDK

class KommunicateService {
    static let shared = KommunicateService()

    func login() {
        let user = KMUser()
        user.userId = "swiftui_user_123"

        Kommunicate.registerUser(user) { response, error in
            if let error = error {
                print("Login error: \(error)")
            } else {
                print("Login success")
            }
        }
    }
}
