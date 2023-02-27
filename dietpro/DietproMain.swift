              
              
import SwiftUI
import Firebase

@main 
struct dietproMain : App {
			
	init() {
	    FirebaseApp.configure()
	       }

	var body: some Scene {
	        WindowGroup {
	            ContentView(model: ModelFacade.getInstance())
	        }
	    }
	} 
