
import Foundation

class UserVO : Hashable, Identifiable, Decodable, Encodable {

  var userName: String = ""
  var gender: String = ""
  var heights: Double = 0.0
  var weights: Double = 0.0
  var activityLevel: String = ""
  var age: Double = 0.0
  var targetCalories: Double = 0.0
  var totalConsumedCalories: Double = 0.0
  var bmr: Double = 0.0

  static var defaultInstance : UserVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultUserVO() -> UserVO
  { if defaultInstance == nil
    { defaultInstance = UserVO() }
    return defaultInstance!
  }

  init(userNamex: String, genderx: String, heightsx: Double, weightsx: Double, activityLevelx: String, agex: Double, targetCaloriesx: Double, totalConsumedCaloriesx: Double, bmrx: Double)  {
    userName = userNamex
    gender = genderx
    heights = heightsx
    weights = weightsx
    activityLevel = activityLevelx
    age = agex
    targetCalories = targetCaloriesx
    totalConsumedCalories = totalConsumedCaloriesx
    bmr = bmrx
  }

  init(x : User)  {
    userName = x.userName
    gender = x.gender
    heights = x.heights
    weights = x.weights
    activityLevel = x.activityLevel
    age = x.age
    targetCalories = x.targetCalories
    totalConsumedCalories = x.totalConsumedCalories
    bmr = x.bmr
  }

  func toString() -> String
  { return " userName= \(userName), gender= \(gender), heights= \(heights), weights= \(weights), activityLevel= \(activityLevel), age= \(age), targetCalories= \(targetCalories), totalConsumedCalories= \(totalConsumedCalories), bmr= \(bmr) "
  }

  func getUserName() -> String
	  { return userName }
	
  func setUserName(x : String)
	  { userName = x }
	  
  func getGender() -> String
	  { return gender }
	
  func setGender(x : String)
	  { gender = x }
	  
  func getHeights() -> Double
	  { return heights }
	
  func setHeights(x : Double)
	  { heights = x }
	  
  func getWeights() -> Double
	  { return weights }
	
  func setWeights(x : Double)
	  { weights = x }
	  
  func getActivityLevel() -> String
	  { return activityLevel }
	
  func setActivityLevel(x : String)
	  { activityLevel = x }
	  
  func getAge() -> Double
	  { return age }
	
  func setAge(x : Double)
	  { age = x }
	  
  func getTargetCalories() -> Double
	  { return targetCalories }
	
  func setTargetCalories(x : Double)
	  { targetCalories = x }
	  
  func getTotalConsumedCalories() -> Double
	  { return totalConsumedCalories }
	
  func setTotalConsumedCalories(x : Double)
	  { totalConsumedCalories = x }
	  
  func getBmr() -> Double
	  { return bmr }
	
  func setBmr(x : Double)
	  { bmr = x }
	  

  static func == (lhs: UserVO, rhs: UserVO) -> Bool
  { return
      lhs.userName == rhs.userName &&
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
