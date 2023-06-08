
import Foundation

class UserBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

    func isCreateUserError(user: User) -> Bool { 
  	resetData() 
  	if user.userName == "" {
  		errorList.append("userName cannot be empty")
  	}
  	if user.gender == "" {
  		errorList.append("gender cannot be empty")
  	}
  	if user.heights != 0 {
	  		errorList.append("heights cannot be zero")
	  	}
  	if user.weights != 0 {
	  		errorList.append("weights cannot be zero")
	  	}
  	if user.activityLevel == "" {
  		errorList.append("activityLevel cannot be empty")
  	}
  	if user.age != 0 {
	  		errorList.append("age cannot be zero")
	  	}
  	if user.targetCalories != 0 {
	  		errorList.append("targetCalories cannot be zero")
	  	}
  	if user.totalConsumedCalories != 0 {
	  		errorList.append("totalConsumedCalories cannot be zero")
	  	}
  	if user.bmr != 0 {
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
