
import SwiftUI

struct CreateMealScreen: View {
 
  @State var bean : MealVO = MealVO()
  @ObservedObject var model : ModelFacade

  @State var showSheet = false
  @State var image = UIImage()
  @State var sourceType:
  UIImagePickerController.SourceType = .photoLibrary
  
  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

		HStack (spacing: 20) {
		Text("MealId:").bold()
		TextField("MealId", text: $bean.mealId).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("MealName:").bold()
		TextField("MealName", text: $bean.mealName).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Calories:").bold()
		TextField("Calories", value: $bean.calories, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Dates:").bold()
		TextField("Dates", text: $bean.dates).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		Image(uiImage: self.image)
		.resizable()
		.scaledToFit()
		.frame(width: 150, height: 150, alignment: .center)
		                
	HStack (spacing: 20) {
		Button("Pick Photo") {
		showSheet = true
		sourceType = .photoLibrary
		}
		                                    
		Button("Take Photo"){
		showSheet = true
		sourceType = .camera
		}
    }.buttonStyle(.bordered)
		HStack (spacing: 20) {
		Text("Analysis:").bold()
		TextField("Analysis", text: $bean.analysis).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("UserName:").bold()
		TextField("UserName", text: $bean.userName).textFieldStyle(RoundedBorderTextFieldStyle())
		}.frame(width: 200, height: 30).border(Color.gray)


      HStack(spacing: 20) {
        Button(action: { 
        	let img : UIImage = image
        if img.pngData() != nil {
        	let imageData:NSData = img.pngData()! as NSData
        	let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        	bean.images = strBase64 
        } else { bean.images = ""}
        	self.model.createMeal(x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreateMeal() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).sheet(isPresented: $showSheet) {
    	ImagePicker(sourceType: sourceType, chosenImage: $image)
    }
     }.navigationTitle("Create Meal")
    }
  }
}

struct CreateMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateMealScreen(model: ModelFacade.getInstance())
    }
}

