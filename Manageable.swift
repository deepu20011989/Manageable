//
//  Manageable.swift
//  CoreDataSample
//
//  Created by Deepak Saxena on 07/08/19.
//  Copyright © 2019 Deepak Saxena. All rights reserved.
//

import Foundation

protocol Manageable: Codable {
    
    func coreDataDictionary() -> [String: Any]?

    static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy
}

extension Manageable {
    
    func coreDataDictionary() -> [String: Any]? {
        return nil
    }
    
    static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .formatted(DateFormatter.iso8601Full)
    }
}

extension Manageable {
    
    static func getObjectList(jsonString: String)-> [Self] {
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy()
        do {
            let objArr = try decoder.decode([Self].self, from: jsonData)
            return objArr
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func getObject(jsonString: String) -> Self {
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy()
        do {
            let obj = try decoder.decode(Self.self, from: jsonData)
            print("\(obj.self)")
            return obj
        } catch(let e) {
            fatalError(e.localizedDescription)
        }
    }
    
    func toJSONString()-> String {
        let dict = try! self.toDictionary()
        return Self.getJSONString(dict)
    }
    
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    /// returns True deep copy of object
    func clone()-> Self {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = Self.dateDecodingStrategy()
        do {
            let obj = try decoder.decode(Self.self, from: jsonData)
            return obj
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private static func getJSONString(_ from: [String: Any]) -> String {
        let theJSONData = try! JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        
        let theJSONText = String(data: theJSONData,
                                 encoding: String.Encoding.ascii)!
        
        return theJSONText

    }
}


extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
