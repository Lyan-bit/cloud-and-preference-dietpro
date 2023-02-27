import Foundation

class MealDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : Meal? = Meal.mealIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> Meal
    { return Meal.mealIndex[id]! }

  static func parseCSV(line: String) -> Meal?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var mealx : Meal? = nil
      mealx = Meal.mealIndex[line1vals[0]]
    if mealx == nil
    { mealx = createByPKMeal(key: line1vals[0]) }
    mealx!.mealId = line1vals[0]
    mealx!.mealName = line1vals[1]
    mealx!.calories = Double(line1vals[2]) ?? 0
    mealx!.dates = line1vals[3]
    mealx!.images = line1vals[4]
    mealx!.analysis = line1vals[5]
    mealx!.userName = line1vals[6]

    return mealx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> Meal?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["mealId"] as! String?
      var mealx : Meal? = Meal.mealIndex[id!]
      if (mealx == nil)
      { mealx = createByPKMeal(key: id!) }

       mealx!.mealId = jsonObj["mealId"] as! String
       mealx!.mealName = jsonObj["mealName"] as! String
       mealx!.calories = jsonObj["calories"] as! Double
       mealx!.dates = jsonObj["dates"] as! String
       mealx!.images = jsonObj["images"] as! String
       mealx!.analysis = jsonObj["analysis"] as! String
       mealx!.userName = jsonObj["userName"] as! String
      return mealx!
    }
    return nil
  }

  static func writeJSON(x : Meal) -> NSDictionary
  { return [    
       "mealId": x.mealId as NSString, 
       "mealName": x.mealName as NSString, 
       "calories": NSNumber(value: x.calories), 
       "dates": x.dates as NSString, 
       "images": x.images as NSString, 
       "analysis": x.analysis as NSString, 
       "userName": x.userName as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [Meal]
  { var res : [Meal] = [Meal]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : Meal? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

