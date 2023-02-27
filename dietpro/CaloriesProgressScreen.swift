import SwiftUI

struct CaloriesProgressScreen: View {
    @ObservedObject var model : ModelFacade
    
	@State var caloriesProgressBean : CaloriesProgressVO = CaloriesProgressVO()
	@State var caloriesProgressResult : Double = 0.0
       	    
    var body: some View {
	  	NavigationView {
	  		ScrollView {
		VStack {
                   
		       HStack (spacing: 20) {
		       Text("User:").bold()
		       Divider()
		       Picker("User", selection: $caloriesProgressBean.user) { ForEach(model.currentUsers) { Text($0.userName).tag($0.userName) } 
		       }.pickerStyle(.menu)
		       }.frame(width: 200, height: 30).border(Color.gray)
	       HStack (spacing: 20){
	           Text("Result:").bold()
	           Text(String(format: "%.2f", caloriesProgressResult))
	       }.frame(width: 200, height: 60).border(Color.gray)
	                    
		HStack (spacing: 20){
	           Button(action: { caloriesProgressResult = self.model.caloriesProgress(x: caloriesProgressBean) }) { Text("OK")}
	                        
	           Button(action: { self.model.cancelCaloriesProgress() }) { Text("Cancel") }
	       }.buttonStyle(.bordered)
	       
            ZStack  (alignment: .center) {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color.green)
               
                Circle()
                    .trim(from: 0.0, to:  caloriesProgressResult/100)
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.green)
                    .rotationEffect(Angle(degrees: 270.0))
                
                if ( caloriesProgressResult/100 > 1.0) {
                    Circle()
                        .trim(from: 0, to: caloriesProgressResult/100 - floor( caloriesProgressResult/100))
                        .stroke(
                            Color.red,
                            style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect (Angle (degrees: -90))
                }

                VStack{
                    Text(String(format: "%.0f %%", caloriesProgressResult))
                        .font(.largeTitle)
                        .bold()
                }
            }//z
            .frame(width: 150.0, height: 150.0)
            .padding(40.0)
        }//v
		.onAppear() {
	        model.loadUser()
			caloriesProgressBean.user = model.currentUser?.userName ?? "userName"
		}
        }.navigationTitle("caloriesProgress")
      }
    }
}

struct CaloriesProgressScreen_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesProgressScreen(model: ModelFacade.getInstance())
    }
}

