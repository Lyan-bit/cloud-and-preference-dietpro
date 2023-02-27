
import SwiftUI

struct AddUsereatsMealScreen: View { 
	@State var x :String = ""
  	@State var y :String = ""

  	@ObservedObject var model : ModelFacade

  var body: some View {
	  	NavigationView {
	  		ScrollView {
    VStack(spacing: 20) {
	   HStack (spacing: 20) {
		  Text(":").bold()
		  Divider()
	      Picker("Meal", selection: $y) { 
	      	ForEach(model.currentMeals) { Text($0.mealId).tag($0.mealId)}
	      }.pickerStyle(.menu)
	   }.frame(width: 200, height: 30).border(Color.gray)

	   HStack (spacing: 20) {
		  Text("userName:").bold()
		  Divider()
	      Picker("User:", selection: $x) { 
	      	ForEach(model.currentUsers) { Text($0.userName).tag($0.userName)}
	      }.pickerStyle(.menu)
	   }.frame(width: 200, height: 30).border(Color.gray)

      HStack(spacing: 20) {
        Button(action: { self.model.addUsereatsMeal(x: x, y: y) } ) { Text("Add") }
        Button(action: { self.model.cancelAddUsereatsMeal() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).onAppear(perform: 
                {
                	model.listMeal()
                	model.listUser()
                  y = model.currentMeal?.mealId ?? "id"
                  x = model.currentUser?.userName ?? "id"})
     }.navigationTitle("addUsereatsMeal")
    }
  }
}
