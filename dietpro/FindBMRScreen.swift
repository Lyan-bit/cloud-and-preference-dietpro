import SwiftUI

struct FindBMRScreen: View {
	
	@State var findBMRBean : FindBMRVO = FindBMRVO()
	@State var findBMRResult : Double = 0.0
	
	@ObservedObject var model : ModelFacade
	
	var body: some View {
	  	NavigationView {
	  		ScrollView {
		VStack {
                   
		       HStack (spacing: 20) {
		       Text("User:").bold()
		       Divider()
		       Picker("User", selection: $findBMRBean.user) { ForEach(model.currentUsers) { Text($0.userName).tag($0.userName) } 
		       }.pickerStyle(.menu)
		       }.frame(width: 200, height: 30).border(Color.gray)

	       HStack (spacing: 20) {
	           Text("Result:").bold()
	           Text(String(format: "%.2f", findBMRResult))
	       }.frame(width: 200, height: 60).border(Color.gray) 
	                      
			   HStack (spacing: 20) {
	          Button(action: { findBMRResult = self.model.findBMR(x: findBMRBean) 
	          }) { Text("OK")}
	                        
	          Button(action: { self.model.cancelFindBMR() }) { Text("Cancel") }
	       }.buttonStyle(.bordered)
	           
	}.onAppear() {
	        model.loadUser()
				findBMRBean.user = model.currentUser?.userName ?? "userName"
	    }
	  }.navigationTitle("findBMR")
	}
  }
}

struct FindBMRScreen_Previews: PreviewProvider {
    static var previews: some View {
        FindBMRScreen(model: ModelFacade.getInstance())
    }
}

