import SwiftUI

struct FindTotalConsumedCaloriesByDateScreen: View {
	
	@State var findTotalConsumedCaloriesByDateBean : FindTotalConsumedCaloriesByDateVO = FindTotalConsumedCaloriesByDateVO()
	@State var findTotalConsumedCaloriesByDateResult : Double = 0.0
	
	@ObservedObject var model : ModelFacade
	
	var body: some View {
	  	NavigationView {
	  		ScrollView {
		VStack {
                   
		       HStack (spacing: 20) {
		       Text("Meals:").bold()
		       Divider()
		       Picker("Meals", selection: $findTotalConsumedCaloriesByDateBean.meals) { ForEach(model.currentMeals) { Text($0.mealId).tag($0.mealId) } 
		       }.pickerStyle(.menu)
		       }.frame(width: 200, height: 30).border(Color.gray)
		       HStack (spacing: 20) {
		       Text("User:").bold()
		       Divider()
		       Picker("User", selection: $findTotalConsumedCaloriesByDateBean.user) { ForEach(model.currentUsers) { Text($0.userName).tag($0.userName) } 
		       }.pickerStyle(.menu)
		       }.frame(width: 200, height: 30).border(Color.gray)
	       HStack (spacing: 20) {
	          Text("Dates:").bold()
		  TextField("Dates", text: $findTotalConsumedCaloriesByDateBean.dates).textFieldStyle(RoundedBorderTextFieldStyle())
	          }.frame(width: 200, height: 30).border(Color.gray)

	       HStack (spacing: 20) {
	           Text("Result:").bold()
	           Text(String(format: "%.2f", findTotalConsumedCaloriesByDateResult))
	       }.frame(width: 200, height: 60).border(Color.gray) 
	                      
			   HStack (spacing: 20) {
	          Button(action: { findTotalConsumedCaloriesByDateResult = self.model.findTotalConsumedCaloriesByDate(x: findTotalConsumedCaloriesByDateBean, dates: findTotalConsumedCaloriesByDateBean.dates) 
	          }) { Text("OK")}
	                        
	          Button(action: { self.model.cancelFindTotalConsumedCaloriesByDate() }) { Text("Cancel") }
	       }.buttonStyle(.bordered)
	           
	}.onAppear() {
	        model.loadMeal()
				findTotalConsumedCaloriesByDateBean.meals = model.currentMeal?.mealId ?? "mealId"
	        model.loadUser()
				findTotalConsumedCaloriesByDateBean.user = model.currentUser?.userName ?? "userName"
	    }
	  }.navigationTitle("findTotalConsumedCaloriesByDate")
	}
  }
}

struct FindTotalConsumedCaloriesByDateScreen_Previews: PreviewProvider {
    static var previews: some View {
        FindTotalConsumedCaloriesByDateScreen(model: ModelFacade.getInstance())
    }
}

