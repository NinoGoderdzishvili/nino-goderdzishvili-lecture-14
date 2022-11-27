//
//  Person.swift
//  nino goderdzishvili lecture 14
//
//  Created by Nino Goderdzishvili on 11/23/22.
//

import Foundation

enum Nationality: String {
    case georgian = "ქართველი"
    case spanish = "ესპანელი"
    case french = "ფრანგი"
    case italian = "იტალიელი"
}

enum Country: String {
    case georgia = "საქართველო"
    case spain = "ესპანეთი"
    case france = "საფრანგეთი"
    case italy = "იტალია"
}

struct Person {
    var firstName: String
    var lastName: String
    var age: UInt
    var nationality: String
    var country: String? = nil
}
