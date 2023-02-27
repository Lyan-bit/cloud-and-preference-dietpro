
import Foundation

class FindTotalConsumedCaloriesByDateVO {
  var meals : String = ""
  var user : String = ""
  var dates : String = ""

  static var defaultInstance : FindTotalConsumedCaloriesByDateVO? = nil
  var errorList : [String] = [String]()

  var result : Double = 0.0

  init() {
  	//init
  }
  
  static func defaultFindTotalConsumedCaloriesByDateVO() -> FindTotalConsumedCaloriesByDateVO
  { if defaultInstance == nil
    { defaultInstance = FindTotalConsumedCaloriesByDateVO() }
    return defaultInstance!
  }

  init(mealsx: String, userx: String, datesx: String)  {
  meals = mealsx
  user = userx
  dates = datesx
  }

  func toString() -> String
  	{ return "" + "meals = " + meals + "user = " + user + "dates = " + dates }

  func getMeals() -> [String:Meal]
  	{ return Meal.mealIndex }
  	
  func setMeals(x : Meal)
  	{ meals = x.userName }
			  
  func getUser() -> User
  	{ return User.userIndex[user]! }
  	
  func setUser(x : User)
  	{ user = x.userName }
			  
  func getDates() -> String
  	{ return dates }
	
  func setDates(x : String)
	{ dates = x }
	  
  func setResult (x: Double) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isFindTotalConsumedCaloriesByDateError() -> Bool
  	{ resetData()
  
 if Meal.mealIndex[meals] == nil
	{ errorList.append("Invalid meals userName: " + meals) }
 if User.userIndex[user] == nil
	{ errorList.append("Invalid user userName: " + user) }


    if errorList.count > 0
    { return true }
    
    return false
  }

  func errors() -> String
  { var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}

