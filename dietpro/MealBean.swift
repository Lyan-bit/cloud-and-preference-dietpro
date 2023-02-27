
import Foundation

class MealBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateMealError(mealId: String, mealName: String, calories: Double, dates: String, images: String, analysis: String, userName: String) -> Bool { 
  	resetData() 
  	if mealId == "" {
  		errorList.append("mealId cannot be empty")
  	}
  	if mealName == "" {
  		errorList.append("mealName cannot be empty")
  	}
  	if calories != 0 {
	  		errorList.append("calories cannot be zero")
	  	}
  	if dates == "" {
  		errorList.append("dates cannot be empty")
  	}
  	if images == "" {
  		errorList.append("images cannot be empty")
  	}
  	if analysis == "" {
  		errorList.append("analysis cannot be empty")
  	}
  	if userName == "" {
  		errorList.append("userName cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditMealError() -> Bool
    { return false }
          
  func isListMealError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteMealerror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
