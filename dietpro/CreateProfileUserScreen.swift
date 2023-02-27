
import SwiftUI

struct CreateProfileUserScreen: View {
 
  @State var bean : UserVO = UserVO()
  @ObservedObject var model : ModelFacade

  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

  VStack(spacing: 20) {
		HStack (spacing: 20) {
		 Text("UserName:").bold()
		 TextField("UserName", text: $bean.userName).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Gender:").bold()
		 TextField("Gender", text: $bean.gender).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Heights:").bold()
		TextField("Heights", value: $bean.heights, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Weights:").bold()
		TextField("Weights", value: $bean.weights, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Age:").bold()
		TextField("Age", value: $bean.age, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

	}
	VStack(spacing: 20) {
		HStack (spacing: 20)  {
		  Text("ActivityLevel:").bold()
		  TextField("ActivityLevel", text: $bean.activityLevel).textFieldStyle(RoundedBorderTextFieldStyle())
		  }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("TargetCalories:").bold()
		 TextField("TargetCalories", value: $bean.targetCalories, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("TotalConsumedCalories:").bold()
		 TextField("TotalConsumedCalories", value: $bean.totalConsumedCalories, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Bmr:").bold()
		 TextField("Bmr", value: $bean.bmr, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

}

      HStack(spacing: 20) {
        Button(action: { 
        	self.model.createUser(x: bean)
        } ) { if (bean.userName  == "") { 
        	Text("Create")
        } else { 
        	Text("Edit")
        } }
        Button(action: { self.model.cancelCreateUser() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
    .onAppear() {
         bean = model.getUser() ?? bean
     }
     }.navigationTitle("Create User")
    }
  }
}

struct CreateProfileUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileUserScreen(model: ModelFacade.getInstance())
    }
}

