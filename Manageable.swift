//
//  Manageable.swift
//  CoreDataSample
//
//  Created by Deepak Saxena on 07/08/19.
//  Copyright © 2019 Deepak Saxena. All rights reserved.
//

import Foundation

public protocol Manageable: Codable {
    static func dateEncodingStrategy() -> JSONEncoder.DateEncodingStrategy
    static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy
}

extension Manageable {
    
    public static func dateEncodingStrategy() -> JSONEncoder.DateEncodingStrategy {
        return .formatted(DateFormatter.iso8601Full)
    }
    
    public static func dateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .formatted(DateFormatter.iso8601Full)
    }
}

//MARK: - Public functions -
extension Manageable {
    
    public func toJSONString()-> String {
        let dict = try! self.toDictionary()
        return Self.getJSONString(dict)
    }
    
    public func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = Self.dateEncodingStrategy()
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    /// returns True deep copy of object
    public func clone()-> Self {
        
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
}

//MARK: - Static functions -
extension Manageable {
    
    public static func getObject(jsonString: String) -> Self {
        
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
    
    public static func getObjectList(jsonString: String)-> [Self] {
        
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
    
    public static func getObject(dictionary: [String: Any])-> Self {
        let jsonString = Self.getJSONString(dictionary)
        return Self.getObject(jsonString: jsonString)
    }
    
    public static func getObjectList(dictionary: [[String: Any]])-> [Self] {
        let jsonString = Self.getJSONString(dictionary)
        return Self.getObjectList(jsonString: jsonString)
    }
}

//MARK: - Private functions -
extension Manageable {
    private static func getJSONString(_ from: Any) -> String {
        let theJSONData = try! JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        
        let theJSONText = String(data: theJSONData,
                                 encoding: String.Encoding.ascii)!
        
        return theJSONText
        
    }
}

//MARK: - DateFormatter extension  -
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

