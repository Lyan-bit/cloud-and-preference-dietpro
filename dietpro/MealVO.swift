
import Foundation

class MealVO : Hashable, Identifiable, Decodable, Encodable {

  var mealId: String = ""
  var mealName: String = ""
  var calories: Double = 0.0
  var dates: String = "" 
  var images: String = "" 
  var analysis: String = ""
  var userName: String = ""

  static var defaultInstance : MealVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultMealVO() -> MealVO
  { if defaultInstance == nil
    { defaultInstance = MealVO() }
    return defaultInstance!
  }

  init(mealIdx: String, mealNamex: String, caloriesx: Double, datesx: String, imagesx: String, analysisx: String, userNamex: String)  {
    mealId = mealIdx
    mealName = mealNamex
    calories = caloriesx
    dates = datesx
    images = imagesx
    analysis = analysisx
    userName = userNamex
  }

  init(x : Meal)  {
    mealId = x.mealId
    mealName = x.mealName
    calories = x.calories
    dates = x.dates
    images = x.images
    analysis = x.analysis
    userName = x.userName
  }

  func toString() -> String
  { return " mealId= \(mealId), mealName= \(mealName), calories= \(calories), dates= \(dates), images= \(images), analysis= \(analysis), userName= \(userName) "
  }

  func getMealId() -> String
	  { return mealId }
	
  func setMealId(x : String)
	  { mealId = x }
	  
  func getMealName() -> String
	  { return mealName }
	
  func setMealName(x : String)
	  { mealName = x }
	  
  func getCalories() -> Double
	  { return calories }
	
  func setCalories(x : Double)
	  { calories = x }
	  
  func getDates() -> String
	  { return dates }
	
  func setDates(x : String)
	  { dates = x }
	  
  func getImages() -> String
	  { return images }
	
  func setImages(x : String)
	  { images = x }
	  
  func getAnalysis() -> String
	  { return analysis }
	
  func setAnalysis(x : String)
	  { analysis = x }
	  
  func getUserName() -> String
	  { return userName }
	
  func setUserName(x : String)
	  { userName = x }
	  

  static func == (lhs: MealVO, rhs: MealVO) -> Bool
  { return
      lhs.mealId == rhs.mealId &&
      lhs.mealName == rhs.mealName &&
      lhs.calories == rhs.calories &&
      lhs.dates == rhs.dates &&
      lhs.images == rhs.images &&
      lhs.analysis == rhs.analysis &&
      lhs.userName == rhs.userName
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(mealId)
    hasher.combine(mealName)
    hasher.combine(calories)
    hasher.combine(dates)
    hasher.combine(images)
    hasher.combine(analysis)
    hasher.combine(userName)
  }

}
