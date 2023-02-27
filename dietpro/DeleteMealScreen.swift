
import SwiftUI

struct DeleteMealScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    
    var body: some View {
  	NavigationView {
  		ScrollView {
      VStack(spacing: 20) {
            HStack (spacing: 20) {
             	Text("mealId:").bold()
             	Divider()
		        Picker("Meal", selection: $objectId) { 
		        	ForEach(model.currentMeals) { Text($0.mealId).tag($0.mealId) }
		        }.pickerStyle(.menu)
		    }.frame(width: 200, height: 30).border(Color.gray)

        HStack(spacing: 20) {
            Button(action: { self.model.deleteMeal(id: objectId) } ) { Text("Delete") }
			Button(action: { self.model.cancelDeleteMeal() } ) { Text("Cancel") }
        }.buttonStyle(.bordered)
      }.padding(.top).onAppear(perform:
        {   objectId = model.currentMeal?.mealId ?? "mealId" 
        	model.listMeal()
        })
        }.navigationTitle("Delete Meal")
       }
    } 
}

struct DeleteMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeleteMealScreen(model: ModelFacade.getInstance())
    }
}

