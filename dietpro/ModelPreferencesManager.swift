import Foundation

class ModelPreferencesManager : ObservableObject {

    @Published var user = UserVO() {
        didSet {
            if let encoded = try? JSONEncoder().encode(user) {
               UserDefaults.standard.set(encoded, forKey: "user")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "user"), let decodedItems = try? 
        	JSONDecoder().decode(UserVO.self, from: savedItems) {
                user = decodedItems
                return
            }
        user = UserVO ()
    }

}

