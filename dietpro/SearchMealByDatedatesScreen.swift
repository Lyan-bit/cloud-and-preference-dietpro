
import SwiftUI

struct SearchMealByDatedatesScreen: View {
    @State var dates:  String = "" 
    @ObservedObject var model : ModelFacade
    @State var bean : [MealVO] = [MealVO] ()
    
    var body: some View {
  	NavigationView { 
      VStack(alignment: HorizontalAlignment.center, spacing: 20) {
      	 Spacer()
      	
		 HStack (spacing: 20) {
		  	Text("dates:").bold()
		  	Divider()
	        Picker("Meal", selection: $dates) { 
	        	ForEach(model.currentMeals) { Text($0.dates).tag($0.dates) }
	        }.pickerStyle(.menu)
	 	 }.frame(width: 200, height: 30).border(Color.gray)
       
		HStack(spacing: 20) {
	        Button(action: { bean = self.model.searchByMealdates(val: dates) } ) { Text("Search") }
	        Button(action: { self.model.cancelSearchMealByDate() } ) { Text("Cancel") }
	      }.buttonStyle(.bordered)
    
		List(bean) { instance in 
			ListMealRowScreen(instance: instance) }
		    
		Spacer()
	
    }.onAppear(perform:
    	{   dates = model.currentMeal?.dates ?? dates 
    		model.listMeal()
    	})
     .navigationTitle("Search by dates")
    }
  }
}

struct SearchMealByDatedatesScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchMealByDatedatesScreen(model: ModelFacade.getInstance())
    }
}
