import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://dietpro-e8868-default-rtdb.europe-west1.firebasedatabase.app/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("meals").observe(.value,
      with:
      { (change) in
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : Meal? = MealDAO.parseJSON(obj: einst)
            keys.append(ex!.mealId)
          }
        }
        var runtimemeals : [Meal] = [Meal]()
        runtimemeals.append(contentsOf: MealAllInstances)

        for (_,obj) in runtimemeals.enumerated()
        { if keys.contains(obj.mealId) {
        	//check
        }
          else
          { killMeal(key: obj.mealId) }
        }
      })
  }

func persistMeal(x: Meal)
{ let evo = MealDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("meals").child(x.mealId)
  { newChild.setValue(evo) }
}

func deleteMeal(x: Meal)
{ if let oldChild = self.database?.child("meals").child(x.mealId)
  { oldChild.removeValue() }
}

}
