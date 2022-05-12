//
//  MedicineViewModel.swift
//  Medico
//
//  Created by iMac on 11/5/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class MedicineViewModel : ObservableObject{
    static let sharedInstance = MedicineViewModel()
    


    func addMedicine(id : String, med : Medicine, completed: @escaping (Bool)-> Void){
        AF.request(
            HOST_URL + "users/addMedicine",
                method: .post,
                parameters: [
                    "id": id,
                    "name": med.name!,
                    "category": med.category!,
                    "notif_time": DateUtils.formatFromDate(date: med.notif_time!) ,
                    "quantity": med.quantity!,
                    "until": DateUtils.formatFromDate(date: med.until!) ,
                    "borA": med.borA!
                ],encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("med added Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
    }
}
    
    func updateMedicine (med: Medicine, completed: @escaping (Bool) -> Void) {
            AF.request(HOST_URL + "users/editMedicine",
                       method: .post,
                       parameters: [
                        "_id":med._id!,
                        "name" : med.name!,
                        "category": med.category!,
                        "notif_time": DateUtils.formatFromDate(date: med.notif_time!),
                        "quantity": med.quantity!,
                        "borA": med.borA!,
                        "until": DateUtils.formatFromDate(date: med.until!)
                        //"photo": utilisateur.photo!,
                    
                       ])
                .response { response in
                    print(response)
                }
        }
    
    func deleteMedicine(pId : String, mId : String, completed: @escaping(Bool) -> Void) {
        AF.request(
            HOST_URL + "users/deleteMedicine",
                method: .post,
                parameters: [
                    "id": pId,
                    "_id": mId
                ],encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("med deleted Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
    }
    }
    
    
    
}
