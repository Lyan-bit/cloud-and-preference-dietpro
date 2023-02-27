
import Foundation

class UserBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateUserError(userName: String, gender: String, heights: Double, weights: Double, activityLevel: String, age: Double, targetCalories: Double, totalConsumedCalories: Double, bmr: Double) -> Bool { 
  	resetData() 
  	if userName == "" {
  		errorList.append("userName cannot be empty")
  	}
  	if gender == "" {
  		errorList.append("gender cannot be empty")
  	}
  	if heights != 0 {
	  		errorList.append("heights cannot be zero")
	  	}
  	if weights != 0 {
	  		errorList.append("weights cannot be zero")
	  	}
  	if activityLevel == "" {
  		errorList.append("activityLevel cannot be empty")
  	}
  	if age != 0 {
	  		errorList.append("age cannot be zero")
	  	}
  	if targetCalories != 0 {
	  		errorList.append("targetCalories cannot be zero")
	  	}
  	if totalConsumedCalories != 0 {
	  		errorList.append("totalConsumedCalories cannot be zero")
	  	}
  	if bmr != 0 {
	  		errorList.append("bmr cannot be zero")
	  	}

    return errorList.count > 0
  }

  func isEditUserError() -> Bool
    { return false }
          
  func isListUserError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteUsererror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
