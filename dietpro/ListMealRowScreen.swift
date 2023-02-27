
import SwiftUI

struct ListMealRowScreen: View {
    
    var instance : MealVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()
    @State var image = UIImage()

      var body: some View { 
      	ScrollView {
    HStack  {
          Text(String(instance.mealId)).bold()
          Text(String(instance.mealName))
          Text(String(instance.calories))
          Text(String(instance.dates))
			Image(uiImage: self.image)
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50, alignment: .center)
								                
          Text(String(instance.analysis))
          Text(String(instance.userName))
    }.onAppear()
          { model.setSelectedMeal(x: instance) 
            let dataDecoded = Data(base64Encoded: instance.images, options: .ignoreUnknownCharacters)
            guard let decodedimage:UIImage = UIImage(data: dataDecoded! as Data) else { return }
            image = decodedimage
          }
        }
      }
    }

    struct ListMealRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListMealRowScreen(instance: MealVO(x: MealAllInstances[0]))
      }
    }

