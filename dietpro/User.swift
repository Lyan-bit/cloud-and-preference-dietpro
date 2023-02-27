
import Foundation

class User : Decodable {
	
  private static var instance : User? = nil	
  
  init() { 
  	//init
  }
  
  init(copyFrom: User) {
  	self.userName = "copy" + copyFrom.userName
  	self.gender = copyFrom.gender
  	self.heights = copyFrom.heights
  	self.weights = copyFrom.weights
  	self.activityLevel = copyFrom.activityLevel
  	self.age = copyFrom.age
  	self.targetCalories = copyFrom.targetCalories
  	self.totalConsumedCalories = copyFrom.totalConsumedCalories
  	self.bmr = copyFrom.bmr
  }
  
  func copy() -> User
  { let res : User = User(copyFrom: self)
  	addUser(instance: res)
  	return res
  }
  
static func defaultInstanceUser() -> User
    { if (instance == nil)
    { instance = createUser() }
    return instance!
}

deinit
{ killUser(obj: self) }	


  var userName: String = ""  /* primary key */
  var gender: String = "" 
  var heights: Double = 0.0 
  var weights: Double = 0.0 
  var activityLevel: String = "" 
  var age: Double = 0.0 
  var targetCalories: Double = 0.0 
  var totalConsumedCalories: Double = 0.0 
  var bmr: Double = 0.0 
    var meals : Set<Meal> = []

  static var userIndex : Dictionary<String,User> = [String:User]()

  static func getByPKUser(index : String) -> User?
  { return userIndex[index] }

  func calculateBMR() -> Double {
			var result = 0.0
			if gender == "male" {
				    bmr  = 66.5 + (13 * weights) + (5 * heights) - (6.76 * age)
			} else {
			        bmr  = 66.5 + (9.56 * weights) + (1.8 * heights) - (4.68 * age)
			}
			  result  = bmr
			return result
			}
  func calculateTargetCalories() -> Double {
			var result = 0.0
			if activityLevel == "low" {
				    targetCalories  = bmr * 1.375
			} else {
			      if activityLevel == "moderate" {
			      	    targetCalories  = bmr * 1.55
			      } else {
			              targetCalories  = bmr * 1.725
			      }
			}
			  result  = targetCalories
			return result
			}

}

  var UserAllInstances : [User] = [User]()

  func createUser() -> User
	{ let result : User = User()
	  UserAllInstances.append(result)
	  return result }
  
  func addUser(instance : User)
	{ UserAllInstances.append(instance) }

  func killUser(obj: User)
	{ UserAllInstances = UserAllInstances.filter{ $0 !== obj } }

  func createByPKUser(key : String) -> User
	{ var result : User? = User.getByPKUser(index: key)
	  if result != nil { 
	  	return result!
	  }
	  result = User()
	  UserAllInstances.append(result!)
	  User.userIndex[key] = result!
	  result!.userName = key
	  return result! }

  func killUser(key : String)
	{ User.userIndex[key] = nil
	  UserAllInstances.removeAll(where: { $0.userName == key })
	}
	
	extension User : Hashable, Identifiable
	{ 
	  static func == (lhs: User, rhs: User) -> Bool
	  {       lhs.userName == rhs.userName &&
      lhs.gender == rhs.gender &&
      lhs.heights == rhs.heights &&
      lhs.weights == rhs.weights &&
      lhs.activityLevel == rhs.activityLevel &&
      lhs.age == rhs.age &&
      lhs.targetCalories == rhs.targetCalories &&
      lhs.totalConsumedCalories == rhs.totalConsumedCalories &&
      lhs.bmr == rhs.bmr
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(userName)
    	hasher.combine(gender)
    	hasher.combine(heights)
    	hasher.combine(weights)
    	hasher.combine(activityLevel)
    	hasher.combine(age)
    	hasher.combine(targetCalories)
    	hasher.combine(totalConsumedCalories)
    	hasher.combine(bmr)
	  }
	}
	

