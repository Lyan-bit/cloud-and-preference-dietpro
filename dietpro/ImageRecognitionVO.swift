
import Foundation

class ImageRecognitionVO {
  var meal : String = ""

  static var defaultInstance : ImageRecognitionVO? = nil
  var errorList : [String] = [String]()

  var result : String = ""

  init() {
  	//init
  }
  
  static func defaultImageRecognitionVO() -> ImageRecognitionVO
  { if defaultInstance == nil
    { defaultInstance = ImageRecognitionVO() }
    return defaultInstance!
  }

  init(mealx: String)  {
  meal = mealx
  }

  func toString() -> String
  	{ return "" + "meal = " + meal }

  func getMeal() -> Meal
  	{ return Meal.mealIndex[meal]! }
  	
  func setMeal(x : Meal)
  	{ meal = x.userName }
			  
  func setResult (x: String) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isImageRecognitionError() -> Bool
  	{ resetData()
  
 if Meal.mealIndex[meal] == nil
	{ errorList.append("Invalid meal userName: " + meal) }


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

