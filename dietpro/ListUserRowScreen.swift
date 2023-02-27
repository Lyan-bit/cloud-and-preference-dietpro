
import SwiftUI

struct ListUserRowScreen: View {
    
    var instance : UserVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

      var body: some View { 
      	ScrollView {
    VStack {
        HStack  {
          Text(String(instance.userName)).bold()
          Text(String(instance.gender))
          Text(String(instance.heights))
          Text(String(instance.weights))
          Text(String(instance.activityLevel))
	    }
        HStack {
          Text(String(instance.age))
          Text(String(instance.targetCalories))
          Text(String(instance.totalConsumedCalories))
          Text(String(instance.bmr))
        }
}.onAppear()
          { model.setSelectedUser(x: instance) 
          }
        }
      }
    }

    struct ListUserRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListUserRowScreen(instance: UserVO(x: UserAllInstances[0]))
      }
    }

