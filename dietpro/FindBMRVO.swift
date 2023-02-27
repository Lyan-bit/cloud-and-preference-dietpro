
import Foundation

class FindBMRVO {
  var user : String = ""

  static var defaultInstance : FindBMRVO? = nil
  var errorList : [String] = [String]()

  var result : Double = 0.0

  init() {
  	//init
  }
  
  static func defaultFindBMRVO() -> FindBMRVO
  { if defaultInstance == nil
    { defaultInstance = FindBMRVO() }
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

  func isFindBMRError() -> Bool
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

