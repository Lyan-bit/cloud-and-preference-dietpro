
import SwiftUI

struct ListMealScreen: View {
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

     var body: some View
     { List(model.currentMeals){ instance in 
     	ListMealRowScreen(instance: instance) }
       .onAppear(perform: { model.listMeal() })
     }
    
}

struct ListMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListMealScreen(model: ModelFacade.getInstance())
    }
}

