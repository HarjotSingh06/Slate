//
//  UserProfile.swift
//  Slate
//

import Foundation
import SwiftData

@Model
final class UserProfile {
    var fullName: String
    var email: String
    var addressLine1: String
    var city: String
    var postCode: String
    
    init(fullName: String = "", email: String = "", addressLine1: String = "", city: String = "", postCode: String = "") {
        self.fullName = fullName
        self.email = email
        self.addressLine1 = addressLine1
        self.city = city
        self.postCode = postCode
    }
}
