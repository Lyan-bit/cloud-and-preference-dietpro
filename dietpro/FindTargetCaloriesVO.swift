
import Foundation

class FindTargetCaloriesVO {
  var user : String = ""

  static var defaultInstance : FindTargetCaloriesVO? = nil
  var errorList : [String] = [String]()

  var result : Double = 0.0

  init() {
  	//init
  }
  
  static func defaultFindTargetCaloriesVO() -> FindTargetCaloriesVO
  { if defaultInstance == nil
    { defaultInstance = FindTargetCaloriesVO() }
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

  func isFindTargetCaloriesError() -> Bool
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

