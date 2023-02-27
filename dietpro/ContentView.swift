              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ModelFacade
	                                       
	var body: some View {
		TabView {
            CreateMealScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+Meal")} 
            ListMealScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListMeal")} 
            EditMealScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("EditMeal")} 
            DeleteMealScreen (model: model).tabItem { 
                        Image(systemName: "4.square.fill")
	                    Text("-Meal")} 
            SearchMealByDatedatesScreen (model: model).tabItem { 
                        Image(systemName: "5.square.fill")
	                    Text("SearchMealByDatedates")} 
            CreateProfileUserScreen (model: model).tabItem { 
                        Image(systemName: "6.square.fill")
	                    Text("+ProfileUser")} 
            ListUserScreen (model: model).tabItem { 
                        Image(systemName: "7.square.fill")
	                    Text("ListUser")} 
            FindTotalConsumedCaloriesByDateScreen (model: model).tabItem { 
                        Image(systemName: "8.square.fill")
	                    Text("FindTotalConsumedCaloriesByDate")} 
            FindTargetCaloriesScreen (model: model).tabItem { 
                        Image(systemName: "9.square.fill")
	                    Text("FindTargetCalories")} 
            FindBMRScreen (model: model).tabItem { 
                        Image(systemName: "10.square.fill")
	                    Text("FindBMR")} 
            CaloriesProgressScreen (model: model).tabItem { 
                        Image(systemName: "11.square.fill")
	                    Text("CaloriesProgress")} 
            AddUsereatsMealScreen (model: model).tabItem { 
                        Image(systemName: "12.square.fill")
	                    Text("AddUsereatsMeal")} 
            RemoveUsereatsMealScreen (model: model).tabItem { 
                        Image(systemName: "13.square.fill")
	                    Text("RemoveUsereatsMeal")} 
            ImageRecognitionScreen (model: model).tabItem { 
                        Image(systemName: "14.square.fill")
	                    Text("ImageRecognition")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ModelFacade.getInstance())
    }
}

