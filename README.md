# Manageable
A Protocol to handle JSONEncoder using Codeable protocol in Swift


import UIKit

/**
 1. Manageable is a protocol so that it has capability to work with struct, class and enums.
 2. Manageable helps us in the way of object-mappers and can convert Objects to JSON or Dictionary<String, Any> type and vice versa.
 3. Manageable also helps us to create true DEEP COPY of objects using it's clone() function.
 4. Manageable having date decoding strategies to parse the date in desired format and iso8601Full is already implemented including yyyyMMdd format other formats can also be provided
 */

struct Person: Manageable {
    
    let id: Quantum //sometimes values are from backend are in String type while same are in Int type for the same type object in different APIs to to manage it we have used Quantum datatype which can manage any dataType in itself this is used for demostrate that how can we handle bad datatype request/response/json
    
    var name: String
    var age: Int
    var gender: Gender
    
    //in-case enum CodingKeys is not provided here then it will pick default keys as per the variable names
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "person_name"
        case age =  "person_age"
        case gender = "sex"
    }
    
    init(id: Quantum, name: String, age: Int, gender: Gender) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
    }
    
}

enum Gender: Int, Manageable {
    case male = 1
    case female
    case other
}
