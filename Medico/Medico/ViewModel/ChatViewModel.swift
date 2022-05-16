//
//  ChatViewModel.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 15/05/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

public class ChatViewModel: ObservableObject{
    
    static let sharedInstance = ChatViewModel()
    
    func recupererMesConversations( completed: @escaping (Bool, [Conversation]?) -> Void ) {
        AF.request(HOST_URL + "chat/my-conversations",
                   method: .post,
                   parameters: [ "sender" : UserDefaults.standard.string(forKey: "id")!],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var conversation : [Conversation]? = []
                    for singleJsonItem in jsonData["conversations"] {
                        conversation!.append(self.makeConversation(jsonItem: singleJsonItem.1))
                    }
                    completed(true, conversation)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func creerNouvelleConversation(recepteur: String, completed: @escaping (Bool, Conversation?) -> Void ) {
        AF.request(HOST_URL + "chat/creer-conversation",
                   method: .post,
                   parameters: [
                    "sender" : UserDefaults.standard.string(forKey: "id")!,
                    "receiver" : recepteur
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true, self.makeConversation(jsonItem: JSON(response.data!)["messages"]))
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }

    func recupererMesMessages(idConversation: String, completed: @escaping (Bool, [Message]?) -> Void ) {
        AF.request(HOST_URL + "chat/my-messages",
                   method: .post,
                   parameters: [ "conversation" : idConversation ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var messages : [Message]? = []
                    for singleJsonItem in jsonData["messages"] {
                        messages!.append(self.makeMessage(jsonItem: singleJsonItem.1))
                    }
                    completed(true, messages)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func envoyerMessage(recepteur: String, description: String, completed: @escaping (Bool, Message?) -> Void ) {
        AF.request(HOST_URL + "chat/envoyer-message",
                   method: .post,
                   parameters: [
                    "sender": UserDefaults.standard.string(forKey: "id")!,
                    "receiver": recepteur,
                    "description": description
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true, self.makeMessage(jsonItem: JSON(response.data!)["newMessage"]))
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func makeMessage(jsonItem: JSON) -> Message {
        return Message(
            sender: Sender(senderId: jsonItem["conversationEnvoyeur"]["sender"].stringValue, displayName: "abc"),
            messageId: jsonItem["_id"].stringValue,
            sentDate: Date(),
            kind: .text(jsonItem["description"].stringValue)
        )
    }
    
    func makeConversation(jsonItem: JSON) -> Conversation {
        return Conversation(
            _id: jsonItem["_id"].stringValue,
            dernierMessage: jsonItem["lastMessage"].stringValue,
            dateDernierMessage: DateUtils.formatFromString(string: jsonItem["lastMessageDate"].stringValue),
            envoyeur: UserViewModel.sharedInstance.makeItem(jsonItem: jsonItem["sender"]),
            recepteur: UserViewModel.sharedInstance.makeItem(jsonItem: jsonItem["receiver"])
        )
    }
    
}

