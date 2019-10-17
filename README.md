# Manageable
 1. Manageable is a protocol so it can be followed by struct, class and enums.
 2. Manageable is helpful to parse JSON and Dictionary<String, Any> into Object and vice versa, works like object-Mapper.
 3. Manageable provides functionality of cloaning/copy (true deep copy) of objects without writing any extra lines and also without following NSObject, NSCopying, Just need to call clone() for the object
 4. Manageable provides date decoding strategies to handle date format of desired types. it provides the way to parse date in iso8601Full and yyyy-MM-dd. we can provide any specific date strategiy to our desired format by implementing the method:
     public static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy
