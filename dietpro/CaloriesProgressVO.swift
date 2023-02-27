
import Foundation

class CaloriesProgressVO {
  var user : String = ""

  static var defaultInstance : CaloriesProgressVO? = nil
  var errorList : [String] = [String]()

  var result : Double = 0.0

  init() {
  	//init
  }
  
  static func defaultCaloriesProgressVO() -> CaloriesProgressVO
  { if defaultInstance == nil
    { defaultInstance = CaloriesProgressVO() }
    return defaultInstance!
  }

  init(userx: String)  {
  user = userx
  }

  func toString() -> String
  	{ return "" + "user = " + user }

  func getUser() -> User
  	{ return User.userIndex[user]! }
  	
  func setUser(x : User)
  	{ user = x.userName }
			  
  func setResult (x: Double) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isCaloriesProgressError() -> Bool
  	{ resetData()
  
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

