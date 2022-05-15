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
    
    func signup(user: User,uiImage: UIImage, completed: @escaping (Bool) -> Void) {
//        AF.request(HOST_URL + "users/register",
//                   method: .post,
//                   parameters: [
//
//                    "email": user.email!,
//                    "password": user.password!,
//                    "name": user.name!,
//                    "birthdate": DateUtils.formatFromDate(date: user.birthdate!) ,
//                    "photo": user.photo!,
//                    "address":user.address!,
//                    "assistant_email":user.assistant_email!,
//                    "blood_type": user.blood_type!,
//                    "emergency_num" : user.emergency_num!,
//                    "is_assistant" : user.is_assistant!,
//                    "phone" : user.phone!
//                   ] ,encoding: JSONEncoding.default)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Validation Successful")
//                    completed(true)
//                case let .failure(error):
//                    print(error)
//                    completed(false)
//                }
//            }
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            print("11111111111111111111")
            let ParametersS =
                    [
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
                    ] as [String : Any]
                    for (key, value) in ParametersS {
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? Int {
                            multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? Double {
                            multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                        
                        }
            }
            print("222222222222222")
        },to: HOST_URL + "users/register",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                    switch response.result{
                    case .success(let data):
                        do {
                            print("33333333333333333333")
                            let json  = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                            if response.response?.statusCode == 201{
                                let jsonData = JSON(response.data!)
                           print("44444444444444")
                                completed(true)

                            }else{
                                print("55555555555555")
                                completed(false)
                            }
                            
                        } catch  {
                            print("66666666666666")
                            print(error.localizedDescription)
                            completed(false)
                            
                            
                        }
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    
    func makeItem(jsonItem: JSON) -> User {
        
        //array parsing
        var medicines :[Medicine] = []
        let medsList = jsonItem["medicines"]
        let medsCount = medsList.array?.count ?? 0

        for i in 0..<medsCount {

           var med = Medicine(

            _id: medsList[i]["_id"].stringValue,
            name: medsList[i]["name"].stringValue,
            quantity: medsList[i]["quantity"].intValue,
            photo: medsList[i]["photo"].stringValue,
            borA: medsList[i]["borA"].stringValue,
            category: medsList[i]["category"].stringValue,
            notif_time : DateUtils.formatFromString(string:medsList[i]["category"].stringValue),
            until : DateUtils.formatFromString(string:medsList[i]["until"].stringValue)
                
            )
            medicines.append(med)
        }
        
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
                    isVerified: jsonItem["isVerified"].boolValue,
                    medicines: medicines
                )
    }
    func getUserById(id: String, completed: @escaping(Bool, User?) -> Void) {
            print("Looking for user --------------------")
            AF.request(HOST_URL + "users/findById",
                       method: .post,
                       parameters: ["id": id],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .response { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        //array reading
                        
                        let user = self.makeItem(jsonItem: jsonData["user"])
                        print("Found user --------------------")
                        print(user)
                        print("-------------------------------")
                       
                        completed(true, user)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false, nil)
                    }
                }
            
        }
        
    func getAssistant(email: String, completed: @escaping(Bool, User?) -> Void) {
            print("Looking for user --------------------")
            AF.request(HOST_URL + "users/getAssistant",
                       method: .post,
                       parameters: ["email": email],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .response { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        //array reading
                        
                        let user = self.makeItem(jsonItem: jsonData["user"])
                        print("Found user --------------------")
                        print(user)
                        print("-------------------------------")
                        UserDefaults.standard.setValue(user.name, forKey: "assistantName")

                        completed(true, user)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false, nil)
                    }
                }
        }
    
    func reSendConfirmationEmail(email: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST_URL + "users/reSendConfirmationEmail",
                   method: .post,
                   parameters: ["email": email])
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
    func forgetPassword(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST_URL + "users/forgetPassword",
                   method: .post,
                   parameters: ["email": email, "codeDeReinit": codeDeReinit])
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
    func changepassword(email: String, newPassword: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST_URL + "users/resetPass",
                   method: .put,
                   parameters: ["email": email,"newPassword": newPassword])
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
    func loginWithSocialApp(email: String, nom: String, completed: @escaping (Bool, User?) -> Void ) {
        AF.request(HOST_URL + "users/loginWithSocial",
                   method: .post,
                   parameters: [
                    "email": email,
                    "name": nom
                    
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    
                    print("this is the new token value : " + jsonData["token"].stringValue)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "idUser")
                   
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    func getPatientslist(id:String,completed: @escaping (Bool,[User]?)->Void){
        
        AF.request(HOST_URL + "users/getPatients",
                   method: .post,
                   parameters: [ "id" : id ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var patientsList : [User]? = []
                    for singleJsonItem in jsonData["response"] {
                        patientsList!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, patientsList)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func updateProfile (user: User, methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
            print(user)
            AF.request(HOST_URL + "users/updateProfile",
                       method: methode,
                       parameters: [
                        "blood_type" : user.blood_type!,
                        "emergency_num": user.emergency_num!,
                        "email": user.email!,
                        "address": user.address!,
                        "name": user.name!,
                        "assistant_email": user.assistant_email!,
                        "birthdate": DateUtils.formatFromDate(date: user.birthdate!),
                        //"photo": utilisateur.photo!,
                    
                       ])
                .response { response in
                    print(response)
                }
        }
    
}
//func getAssistantName (assistant_email: String , methode : HTTPMethod, completed: @escaping(Bool)->Void){
//    AF.request(HOST_URL + "users/getAssistantName",
//               method: methode,
//               parameters: [
//                "assistant_email" : assistant_email!,
//               ])
//        .response { response in
//            print(response)
//        }
//}
//}
