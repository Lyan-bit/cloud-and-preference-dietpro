import SwiftUI

struct FindTargetCaloriesScreen: View {
	
	@State var findTargetCaloriesBean : FindTargetCaloriesVO = FindTargetCaloriesVO()
	@State var findTargetCaloriesResult : Double = 0.0
	
	@ObservedObject var model : ModelFacade
	
	var body: some View {
	  	NavigationView {
	  		ScrollView {
		VStack {
                   
		       HStack (spacing: 20) {
		       Text("User:").bold()
		       Divider()
		       Picker("User", selection: $findTargetCaloriesBean.user) { ForEach(model.currentUsers) { Text($0.userName).tag($0.userName) } 
		       }.pickerStyle(.menu)
		       }.frame(width: 200, height: 30).border(Color.gray)

	       HStack (spacing: 20) {
	           Text("Result:").bold()
	           Text(String(format: "%.2f", findTargetCaloriesResult))
	       }.frame(width: 200, height: 60).border(Color.gray) 
	                      
			   HStack (spacing: 20) {
	          Button(action: { findTargetCaloriesResult = self.model.findTargetCalories(x: findTargetCaloriesBean) 
	          }) { Text("OK")}
	                        
	          Button(action: { self.model.cancelFindTargetCalories() }) { Text("Cancel") }
	       }.buttonStyle(.bordered)
	           
	}.onAppear() {
	        model.loadUser()
				findTargetCaloriesBean.user = model.currentUser?.userName ?? "userName"
	    }
	  }.navigationTitle("findTargetCalories")
	}
  }
}

struct FindTargetCaloriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FindTargetCaloriesScreen(model: ModelFacade.getInstance())
    }
}

