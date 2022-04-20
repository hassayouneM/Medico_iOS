//
//  UserViewModel.swift
//  Medico
//
//  Created by iMac on 20/4/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UserViewModel : ObservableObject{
    static let sharedInstance = UserViewModel()
    
    
    func signin(email : String, password: String, completed : @escaping (Bool, Any?) -> Void) {
        AF.request(HOST_URL + "users/login",
                   method: .post,
                   parameters: ["email": email, "password": password])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "id")
                    print(user)
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func signup(user: User, completed: @escaping (Bool) -> Void) {
        AF.request(HOST_URL + "users/register",
                   method: .post,
                   parameters: [
                    
                    "email": user.email!,
                    "password": user.password!,
                    "name": user.name!,
                    "birthdate": DateUtils.formatFromDate(date: user.birthdate!) ,
                    "photo": user.photo!,
                    "address":user.address!,
                    "assistant_email":user.assistant_email!,
                    "blood_type": user.blood_type!,
                    "emergency_num" : user.emergency_num!,
                    "is_assistant" : user.is_assistant!,
                    "phone" : user.phone!
                   ] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeItem(jsonItem: JSON) -> User {
        
        
        return User(
            _id: jsonItem["_id"].stringValue,
            name: jsonItem["name"].stringValue,
            birthdate: DateUtils.formatFromString(string: jsonItem["birthdate"].stringValue),
            address : jsonItem["address"].stringValue,
            assistant_email : jsonItem["assistant_email"].stringValue,
            blood_type : jsonItem["blood_type"].stringValue,
            email: jsonItem["email"].stringValue,
            emergency_num : jsonItem["emergency_num"].intValue,
            is_assistant : jsonItem["is_assistant"].boolValue,
            password: jsonItem["password"].stringValue,
            phone : jsonItem["phone"].intValue,
            photo: jsonItem["idPhoto"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
          
        )
    }
    func getUserById(id: String, completed: @escaping(Bool, User?) -> Void) {
        print("Looking for user --------------------")
        AF.request(HOST_URL + "users/findById",
                   method: .post,
                   parameters: ["id": UserDefaults.standard.string(forKey: "id")],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    print("Found user --------------------")
                    print(user)
                    print("-------------------------------")
                   
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }    }
}
