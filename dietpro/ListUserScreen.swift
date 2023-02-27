
import SwiftUI

struct ListUserScreen: View {
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

     var body: some View
     { List(model.currentUsers){ instance in 
     	ListUserRowScreen(instance: instance) }
       .onAppear(perform: { model.listUser() })
     }
    
}

struct ListUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListUserScreen(model: ModelFacade.getInstance())
    }
}

