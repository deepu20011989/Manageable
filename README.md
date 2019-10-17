# Manageable
 1. Manageable is a protocol so it can be followed by struct, class and enums.
 2. Manageable is helpful to parse JSON and Dictionary<String, Any> into Object and vice versa, works like object-Mapper.
 3. Manageable provides functionality of cloaning/copy (true deep copy) of objects without writing any extra lines and also without following NSObject, NSCopying, Just need to call clone() for the object
 4. Manageable provides date decoding strategies to handle date format of desired types. it provides the way to parse date in iso8601Full and yyyy-MM-dd. we can provide any specific date strategiy to our desired format by implementing the method:
     public static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy

# Quantum
 Quantum is a special data type that is very useful in the follwoing cases

1. let suppose we have an Object with a property id: Int but (in some cases) sometimes from backend in different APIs we are getting id as Int and in other APIs we are getting the same object with Id of type String (String containig Int).
2. In case of DataType changed from Int to float or Int to String

So these type of things can be of type Quantum and can be managed easily without writing any specific code.

var age: Quantum = 10 OR var age: Quantum = "10"
var id: Quantum = "12345"

we can also have the specific type from these in the following way

let ageIntValue = age.intValue OR let ageStringValue = age.stringValue
let idStringValue = id.stringValue OR let idIntValue = id.intValue

this is workable with data types like: Int, Float, Double, Bool, String

if in case casting using intValue or stringValue, or to any other type failes it returns the default value of that type
for Int it will return 0, for String it will return "" (blank string) for bool it will return false and double and float it will return 0.0
