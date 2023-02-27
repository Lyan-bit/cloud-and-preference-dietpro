	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ 
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
	
  let mealOclType = createByPKOclType(key: "Meal")
  mealOclType.actualMetatype = Meal.self

  let mealMealId = createOclAttribute()
  	  mealMealId.name = "mealId"
  	  mealMealId.type = stringOclType
  	  mealOclType.attributes.append(mealMealId)
  let mealMealName = createOclAttribute()
  	  mealMealName.name = "mealName"
  	  mealMealName.type = stringOclType
  	  mealOclType.attributes.append(mealMealName)
  let mealCalories = createOclAttribute()
  	  mealCalories.name = "calories"
  	  mealCalories.type = doubleOclType
  	  mealOclType.attributes.append(mealCalories)
  let mealDates = createOclAttribute()
  	  mealDates.name = "dates"
  	  mealDates.type = stringOclType
  	  mealOclType.attributes.append(mealDates)
  let mealImages = createOclAttribute()
  	  mealImages.name = "images"
  	  mealImages.type = stringOclType
  	  mealOclType.attributes.append(mealImages)
  let mealAnalysis = createOclAttribute()
  	  mealAnalysis.name = "analysis"
  	  mealAnalysis.type = stringOclType
  	  mealOclType.attributes.append(mealAnalysis)
  let mealUserName = createOclAttribute()
  	  mealUserName.name = "userName"
  	  mealUserName.type = stringOclType
  	  mealOclType.attributes.append(mealUserName)
  let userOclType = createByPKOclType(key: "User")
  userOclType.actualMetatype = User.self

  let userUserName = createOclAttribute()
  	  userUserName.name = "userName"
  	  userUserName.type = stringOclType
  	  userOclType.attributes.append(userUserName)
  let userGender = createOclAttribute()
  	  userGender.name = "gender"
  	  userGender.type = stringOclType
  	  userOclType.attributes.append(userGender)
  let userHeights = createOclAttribute()
  	  userHeights.name = "heights"
  	  userHeights.type = doubleOclType
  	  userOclType.attributes.append(userHeights)
  let userWeights = createOclAttribute()
  	  userWeights.name = "weights"
  	  userWeights.type = doubleOclType
  	  userOclType.attributes.append(userWeights)
  let userActivityLevel = createOclAttribute()
  	  userActivityLevel.name = "activityLevel"
  	  userActivityLevel.type = stringOclType
  	  userOclType.attributes.append(userActivityLevel)
  let userAge = createOclAttribute()
  	  userAge.name = "age"
  	  userAge.type = doubleOclType
  	  userOclType.attributes.append(userAge)
  let userTargetCalories = createOclAttribute()
  	  userTargetCalories.name = "targetCalories"
  	  userTargetCalories.type = doubleOclType
  	  userOclType.attributes.append(userTargetCalories)
  let userTotalConsumedCalories = createOclAttribute()
  	  userTotalConsumedCalories.name = "totalConsumedCalories"
  	  userTotalConsumedCalories.type = doubleOclType
  	  userOclType.attributes.append(userTotalConsumedCalories)
  let userBmr = createOclAttribute()
  	  userBmr.name = "bmr"
  	  userBmr.type = doubleOclType
  	  userOclType.attributes.append(userBmr)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "Meal"
  { let x = try? decoder.decode(Meal.self, from: jdata) 
  return x
}
if typeName == "User"
  { let x = try? decoder.decode(User.self, from: jdata) 
  return x
}
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	var cdb : FirebaseDB = FirebaseDB.getInstance()
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
		// init
	}
	      
	@Published var currentMeal : MealVO? = MealVO.defaultMealVO()
	@Published var currentMeals : [MealVO] = [MealVO]()
	@Published private var preference = ModelPreferencesManager()
	@Published var currentUser : UserVO? = UserVO.defaultUserVO()
	@Published var currentUsers : [UserVO] = [UserVO]()

		func createMeal(x : MealVO) {
		    if let obj = getMealByPK(val: x.mealId)
			{ cdb.persistMeal(x: obj) }
			else {
			let item : Meal = createByPKMeal(key: x.mealId)
		      item.mealId = x.getMealId()
		      item.mealName = x.getMealName()
		      item.calories = x.getCalories()
		      item.dates = x.getDates()
		      item.images = x.getImages()
		      item.analysis = x.getAnalysis()
		      item.userName = x.getUserName()
			cdb.persistMeal(x: item)
			}
			currentMeal = x
	}
			
	func cancelCreateMeal() {
		//cancel function
	}
	
	func deleteMeal(id : String) {
		if let obj = getMealByPK(val: id)
		{ cdb.deleteMeal(x: obj) }
	}
		
	func cancelDeleteMeal() {
		//cancel function
	}
	
	func cancelEditMeal() {
		//cancel function
	}

		func cancelSearchMealByDate() {
	//cancel function
}

    func createUser(x : UserVO) {
        let res : User = createByPKUser(key: x.userName)
        res.userName = x.userName
        res.gender = x.gender
        res.heights = x.heights
        res.weights = x.weights
        res.activityLevel = x.activityLevel
        res.age = x.age
        res.targetCalories = x.targetCalories
        res.totalConsumedCalories = x.totalConsumedCalories
        res.bmr = x.bmr

        currentUser = x
	    currentUsers = [UserVO] ()
	    currentUsers.append(x)
	    
        preference.user = x
    }
    
    func getUser () -> UserVO? {
    	currentUser = preference.user
    	if (currentUser != nil) {
	    currentUsers = [UserVO] ()
	    currentUsers.append(currentUser!)
	    }
        return currentUser
    }
    
	func cancelCreateUser() {
		//cancel function
	}
	
		func findTotalConsumedCaloriesByDate (x: FindTotalConsumedCaloriesByDateVO, dates: String) -> Double {
	      var result = 0.0

var totalConsumedCalories: Double
  totalConsumedCalories  = 0.0
for (_,meal) in x.getMeals() {
	if meal.userName == x.getUser().userName && meal.dates == dates {
		    totalConsumedCalories  = totalConsumedCalories + meal.calories
	}
}
  x.getUser().totalConsumedCalories  = totalConsumedCalories
persistUser (x: x.getUser())
  result  = totalConsumedCalories
	if x.isFindTotalConsumedCaloriesByDateError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindTotalConsumedCaloriesByDate() {
		//cancel function
	}
	          
		func findTargetCalories (x: FindTargetCaloriesVO) -> Double {
	      var result = 0.0

  x.getUser().targetCalories  = x.getUser().calculateTargetCalories()
persistUser (x: x.getUser())
  result  = x.getUser().targetCalories
	if x.isFindTargetCaloriesError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindTargetCalories() {
		//cancel function
	}
	          
		func findBMR (x: FindBMRVO) -> Double {
	      var result = 0.0

  x.getUser().bmr  = x.getUser().calculateBMR()
persistUser (x: x.getUser())
  result  = x.getUser().bmr
	if x.isFindBMRError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelFindBMR() {
		//cancel function
	}
	          
		func caloriesProgress (x: CaloriesProgressVO) -> Double {
	      var result = 0.0

var progress: Double
  progress  = (x.getUser().totalConsumedCalories / x.getUser().targetCalories) * 100
persistUser (x: x.getUser())
  result  = progress
	if x.isCaloriesProgressError()
	   {   return result }
        x.setResult(x: result )
	   
	return result
        
    }
       
	func cancelCaloriesProgress() {
		//cancel function
	}
	          
  func addUsereatsMeal(x: String, y: String) {
		if let obj = getMealByPK(val: y) {
		obj.userName = x
		cdb.persistMeal(x: obj)
		}
	}
	
	func cancelAddUsereatsMeal() {
		//cancel function
	}
	
  func removeUsereatsMeal(x: String, y: String) {
		if let obj = getMealByPK(val: y) {
		obj.userName = "NULL"
		cdb.persistMeal(x: obj)
		}
	}
		
	func cancelRemoveUsereatsMeal() {
		//cancel function
	}

    func imageRecognition(x : String) -> String {
        guard let obj = getMealByPK(val: x)
        else {
            return "Please selsect valid mealId"
        }
        
		let dataDecoded = Data(base64Encoded: obj.images, options: .ignoreUnknownCharacters)
		let decodedimage:UIImage = UIImage(data: dataDecoded! as Data)!
        		
    	guard let pixelBuffer = decodedimage.pixelBuffer() else {
        	return "Error"
    	}
    
        // Hands over the pixel buffer to ModelDatahandler to perform inference
        let inferencesResults = modelParser?.runModel(onFrame: pixelBuffer)
        
        // Formats inferences and resturns the results
        guard let firstInference = inferencesResults else {
          return "Error"
        }
        
        obj.analysis = firstInference[0].label
        persistMeal(x: obj)
        
        return firstInference[0].label
        
    }
    
	func cancelImageRecognition() {
		//cancel function
	}
	    

	func loadUser() {
			let res : [UserVO] = listUser()
			
			for (_,x) in res.enumerated() {
				let obj = createByPKUser(key: x.userName)
		        obj.userName = x.getUserName()
        obj.gender = x.getGender()
        obj.heights = x.getHeights()
        obj.weights = x.getWeights()
        obj.activityLevel = x.getActivityLevel()
        obj.age = x.getAge()
        obj.targetCalories = x.getTargetCalories()
        obj.totalConsumedCalories = x.getTotalConsumedCalories()
        obj.bmr = x.getBmr()
				}
			 currentUser = res.first
			 currentUsers = res
		}
		
		func listUser() -> [UserVO] {
			currentUser = getUser()
	            if currentUser != nil {
	                currentUsers = [UserVO]()
	                currentUsers.append(currentUser!)
	            }
            return currentUsers
		}
						
	func stringListUser() -> [String] { 
		currentUsers = listUser()
		var res : [String] = [String]()
		for (_,obj) in currentUsers.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
	func getUserByPK(val: String) -> User? {
		var res : User? = User.getByPKUser(index: val)
		if res == nil {
		   res = createByPKUser(key: preference.user.userName)
		}
		return res 
	}
			
	func retrieveUser(val: String) -> User? {
		let res : User? = getUserByPK(val: val)
		return res 
	}
			
	func allUserids() -> [String] {
		var res : [String] = [String]()
		for (_,item) in currentUsers.enumerated()
		{ res.append(item.userName + "") }
		return res
	}
			
	func setSelectedUser(x : UserVO)
		{ currentUser = x }
			
	func setSelectedUser(i : Int) {
		if 0 <= i && i < currentUsers.count
		{ currentUser = currentUsers[i] }
	}
			
	func getSelectedUser() -> UserVO?
		{ return currentUser }
			
	func persistUser(x : User) {
		let vo : UserVO = UserVO(x: x)
		editUser(x: vo)
	}
		
	func editUser(x : UserVO) {
		let val : String = x.userName
		let res : User? = User.getByPKUser(index: val)
		if res != nil {
		res!.userName = x.userName
		res!.gender = x.gender
		res!.heights = x.heights
		res!.weights = x.weights
		res!.activityLevel = x.activityLevel
		res!.age = x.age
		res!.targetCalories = x.targetCalories
		res!.totalConsumedCalories = x.totalConsumedCalories
		res!.bmr = x.bmr
		}
		currentUser = x
		preference.user = x
	 }
		
    func cancelUserEdit() {
    	//cancel function
    }
    
 	func searchByUseruserName(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.userName == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsergender(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.gender == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserheights(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.heights == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserweights(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.weights == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUseractivityLevel(val : String) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.activityLevel == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserage(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.age == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsertargetCalories(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.targetCalories == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUsertotalConsumedCalories(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.totalConsumedCalories == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		
 	func searchByUserbmr(val : Double) -> [UserVO] {
		currentUser = getUser()
        if currentUser != nil && currentUser?.bmr == val {
           currentUsers = [UserVO]()
           currentUsers.append(currentUser!)
        }
        return currentUsers
		}
		

    func listMeal() -> [MealVO] {
		currentMeals = [MealVO]()
		let list : [Meal] = MealAllInstances
		for (_,x) in list.enumerated()
		{ currentMeals.append(MealVO(x: x)) }
		return currentMeals
	}
			
	func loadMeal() {
		let res : [MealVO] = listMeal()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKMeal(key: x.mealId)
	        obj.mealId = x.getMealId()
        obj.mealName = x.getMealName()
        obj.calories = x.getCalories()
        obj.dates = x.getDates()
        obj.images = x.getImages()
        obj.analysis = x.getAnalysis()
        obj.userName = x.getUserName()
			}
		 currentMeal = res.first
		 currentMeals = res
	}
		
	func stringListMeal() -> [String] { 
		var res : [String] = [String]()
		for (_,obj) in currentMeals.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
    func searchByMealmealId(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.mealId == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealmealName(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.mealName == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealcalories(val : Double) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.calories == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealdates(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.dates == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealimages(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.images == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealanalysis(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.analysis == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByMealuserName(val : String) -> [MealVO] {
	    var resultList: [MealVO] = [MealVO]()
	    let list : [Meal] = MealAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.userName == val) {
	    		resultList.append(MealVO(x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getMealByPK(val: String) -> Meal?
		{ return Meal.mealIndex[val] }
			
	func retrieveMeal(val: String) -> Meal?
			{ return Meal.mealIndex[val] }
			
	func allMealids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentMeals.enumerated()
			{ res.append(item.mealId + "") }
			return res
	}
			
	func setSelectedMeal(x : MealVO)
		{ currentMeal = x }
			
	func setSelectedMeal(i : Int) {
		if i < currentMeals.count
		{ currentMeal = currentMeals[i] }
	}
			
	func getSelectedMeal() -> MealVO?
		{ return currentMeal }
			
	func persistMeal(x : Meal) {
		let vo : MealVO = MealVO(x: x)
		cdb.persistMeal(x: x)
		currentMeal = vo
	}
		
	func editMeal(x : MealVO) {
		if let obj = getMealByPK(val: x.mealId) {
		 obj.mealId = x.getMealId()
		 obj.mealName = x.getMealName()
		 obj.calories = x.getCalories()
		 obj.dates = x.getDates()
		 obj.images = x.getImages()
		 obj.analysis = x.getAnalysis()
		 obj.userName = x.getUserName()
		cdb.persistMeal(x: obj)
		}
	    currentMeal = x
	}
			
	}
