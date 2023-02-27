
import SwiftUI

struct EditMealScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    @State var bean : Meal = Meal()
    
    @State var showSheet = false
    @State var image = UIImage()
    @State var sourceType:
    UIImagePickerController.SourceType = .photoLibrary
  
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
      	HStack (spacing: 20) {
      	Text("mealId:")
      	Divider()
        Picker("Meal", selection: $objectId) { 
        	ForEach(model.currentMeals) { Text($0.mealId).tag($0.mealId) }
        }.pickerStyle(.menu)
        }.frame(width: 200, height: 30).border(Color.gray)
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


HStack (spacing: 20) {
		Button(action: { 
	bean = model.getMealByPK(val: objectId) ?? bean
			let dataDecoded = Data(base64Encoded: bean.images, options: .ignoreUnknownCharacters)
			guard let decodedimage:UIImage = UIImage(data: dataDecoded! as Data) else { return }
			image = decodedimage
		} ) { Text("Search") }
        Button(action: { 
        	let img : UIImage = image
        if img.pngData() != nil {
        	let imageData:NSData = img.pngData()! as NSData
        	let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        	bean.images = strBase64 
        } else { bean.images = ""}
        	self.model.editMeal(x: MealVO(x: bean))
        } ) { Text("Edit") }
        Button(action: { self.model.cancelEditMeal() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).sheet(isPresented: $showSheet) {
    	ImagePicker(sourceType: sourceType, chosenImage: $image)
    }
    .onAppear(perform:
            {   objectId = model.currentMeal?.mealId ?? "id" 
            	model.listMeal()
            })
    	}.navigationTitle("Edit Meal")
     }
  }
}

struct EditMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditMealScreen(model: ModelFacade.getInstance())
    }
}
