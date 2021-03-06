
import FirebaseAuth
import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject
{

  private let database = Firestore.firestore()
  var users = [User]()
  var posts = [Post]()
  var items = [Item]()
  var notifications = [Notification]()
  var notification_sequences = [Notification_Sequence]()
  var itemsWithPostsAvailable = [PostItem]()
  var itemsWithSavedPosts = [PostItem]()
  var itemsWithMyPosts = [PostItem]()


  func addUser(user:User){
    database.collection("Users").document(user.id).setData(user.dictionary)
  }

  func fetchUser() {
    database.collection("Users").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let email = document.get("email") as? String ?? ""
              let password = document.get("password") as? String ?? ""
              let user_image = document.get("user_image") as? String ?? ""
              let first_name = document.get("first_name") as? String ?? ""
              let last_name = document.get("last_name") as? String ?? ""
              let campus_location = document.get("campus_location") as? String ?? ""
              let saved_post_list = document.get("saved_post_list") as? [String] ?? []
              let my_post_list = document.get("my_post_list") as? [String] ?? []
              let date_joined = document.get("date_joined") as? Date ?? Date()
              let suggestion_preference = document.get("suggestion_preference") as? Bool ?? true
              let user_status = document.get("user_status") as? Bool ?? true
              self.users.append(User(id: id, email: email, password: password, user_image: user_image,first_name: first_name, last_name: last_name, campus_location: campus_location, saved_post_list: saved_post_list, my_post_list: my_post_list, date_joined: date_joined, suggestion_preference: suggestion_preference, user_status: user_status))
            }
        }
    }
  }
  
  func checkUserExist(email:String, completion: @escaping (Bool)->Void){
    var present = false
    database.collection("Users").whereField("email", isEqualTo: email)
      .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
              if(querySnapshot!.count != 0)
              {
                present = true
              }
              completion(present)
            }
    }
  }
//  // load post in Firestore
//  func addPost_old() {
//    posts.append(Post(id: "P00001", last_modified_timestamp: Date(), Availability: "Available", post_creation_date: Date()))
//    posts.append(Post(id: "P00002", last_modified_timestamp: Date(), Availability: "Available", post_creation_date: Date()))
//    posts.append(Post(id: "P00003", last_modified_timestamp: Date(), Availability: "Available", post_creation_date: Date()))
//    posts.append(Post(id: "P00004", last_modified_timestamp: Date(), Availability: "Available", post_creation_date: Date()))
//    for post in posts{
//      database.collection("Posts").document(post.id).setData(post.dictionary)
//    }
//    print("Posts loaded")
//  }

  func addPost(post:Post) {
    database.collection("Posts").document(post.id).setData(post.dictionary)
  }

  func addItem(item: Item) {
    database.collection("Items").document(item.id).setData(item.dictionary)
  }

//  func addItem_old() {
//    items.append(Item(id: "I00001", post_id: "P00001", item_title: "Lamp", item_description: "A lamp for the study table", item_category: "Electronics", item_buy: false, condition: "Almost new", price: 15.90, images: ["https://..jpg"], zip_code: "15213", delivery: true, pickup_location: "3229 Hardie Way"))
//    items.append(Item(id: "I00002", post_id: "P00004", item_title: "Vacuum Cleaner", item_description: "1 year old vacuum cleaner with auto detection technology available at reasonable price.", item_category: "Cleaning-Appliance", item_buy: false, condition: "New", price: 19.00, images: ["https://..jpg"], zip_code: "15213", delivery: false, pickup_location: "123 Forbes Avenue, Pittburgh"))
//
//    for item in items{
//      database.collection("Items").document(item.id).setData(item.dictionary)
//    }
//    print("Items loaded")
//  }

//  func addNotification() {
//    notifications.append(Notification(id: "N00001", user_id: "U00001", notification_on: true, saved_post_change_alert: true, sequence: ["NS00001"]))
//
//    for notification in notifications{
//      database.collection("Notifications").document(notification.id).setData(notification.dictionary)
//    }
//    print("message_sequences loaded")
//  }

//  func addNotification_Sequence() {
//    notification_sequences.append(Notification_Sequence(id: "NS00001", post_id: "P00002", timestamp_notf: Date(), content: "Price of the apartment changed"))
//
//    for notification_sequence in notification_sequences{
//      database.collection("Notification_Sequences").document(notification_sequence.id).setData(notification_sequence.dictionary)
//    }
//    print("notification_sequence loaded")
//  }

//  func fetchAllPost() {
//    print("fetching posts")
//    database.collection("Posts").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//              let id = document.documentID
//              let last_modified_timestamp = document.get("last_modified_timestamp") as? Date ?? Date()
//              let Availability = document.get("Availability") as? String ?? ""
//              let post_creation_date = document.get("post_creation_date") as? Date ?? Date()
//
//              self.posts.append(Post(id: id, last_modified_timestamp: last_modified_timestamp, Availability: Availability, post_creation_date: post_creation_date))
//           }
//          for post in self.posts{
//            print(post)
//          }
//          print("Posts printed")
//        }
//    }
//  }

  func fetchAllItem() {
    print("fetching items")
    database.collection("Items").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
            let id = document.documentID
            let post_id = document.get("post_id") as? String ?? ""
            let item_title = document.get("item_title") as? String ?? ""
            let item_description = document.get("item_description") as? String ?? ""
            let item_category = document.get("item_category") as? String ?? ""
            let item_buy = document.get("item_buy") as? Bool ?? false
            let condition = document.get("condition") as? String ?? ""
            let price = document.get("price") as? Double ?? 0
            let images = document.get("images") as? [String] ?? []
            let zip_code = document.get("zip_code") as? String ?? ""
            let delivery = document.get("delivery") as? Bool ?? false
            let pickup_location = document.get("pickup_location") as? String ?? ""

            self.items.append(Item(id: id, post_id: post_id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location))
//                print("\(document.documentID) => \(document.data())")
            }
              for item in self.items{
                print(item)
              }
            print("Items printed")
        }
    }
  }

  // using this function for fetching all items with their posts to render details in items listing
  func fetchAllItemsWithPostsAvailable(completion: @escaping ([PostItem])->Void) {
    self.itemsWithPostsAvailable = []
    database.collection("Items").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let item_title = document.get("item_title") as? String ?? ""
              let item_description = document.get("item_description") as? String ?? ""
              let item_category = document.get("item_category") as? String ?? ""
              let item_buy = document.get("item_buy") as? Bool ?? false
              let condition = document.get("condition") as? String ?? ""
              let price = document.get("price") as? Double ?? 0
              let images = document.get("images") as? [String] ?? []
              let zip_code = document.get("zip_code") as? String ?? ""
              let delivery = document.get("delivery") as? Bool ?? false
              let pickup_location = document.get("pickup_location") as? String ?? ""
              self.fetchPostBasedOnPostId(postId: post_id) {(post) in
                if(post.Availability == "Available")
                {
                  self.itemsWithPostsAvailable.append(PostItem(postId: post_id, last_modified_timestamp: post.last_modified_timestamp, Availability: post.Availability, post_creation_date: post.post_creation_date, itemId: id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location, isSaved: false))
                }
                completion(self.itemsWithPostsAvailable)
              }
              }

          }
      }
  }
  //using it for savepost
  func fetchSavedPost(userId: String, completion: @escaping ([String])->Void){

    database.collection("Users").document(userId).getDocument { (document, error) in
        if let document = document, document.exists {
            let saved_post_list = document.get("saved_post_list") as? [String] ?? []
//            print("Document data: \(saved_post_list)")


          completion(saved_post_list)
        } else {
            print("Document does not exist")
        }
      }
      }
  //using it for savepost
  func fetchAllSavedPosts(savePostArray: [String], completion: @escaping ([PostItem])->Void) {
    self.itemsWithSavedPosts = []
    database.collection("Items").whereField("post_id", in: savePostArray).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let item_title = document.get("item_title") as? String ?? ""
              let item_description = document.get("item_description") as? String ?? ""
              let item_category = document.get("item_category") as? String ?? ""
              let item_buy = document.get("item_buy") as? Bool ?? false
              let condition = document.get("condition") as? String ?? ""
              let price = document.get("price") as? Double ?? 0
              let images = document.get("images") as? [String] ?? []
              let zip_code = document.get("zip_code") as? String ?? ""
              let delivery = document.get("delivery") as? Bool ?? false
              let pickup_location = document.get("pickup_location") as? String ?? ""
              self.fetchPostBasedOnPostId(postId: post_id) {(post) in
                self.itemsWithSavedPosts.append(PostItem(postId: post_id, last_modified_timestamp: post.last_modified_timestamp, Availability: post.Availability, post_creation_date: post.post_creation_date, itemId: id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location,isSaved: false))

                completion(self.itemsWithSavedPosts)
              }
              }
          }
      }
  }
  
  //using it for mypost
  func fetchMyPost(userId: String, completion: @escaping ([String])->Void){

    database.collection("Users").document(userId).getDocument { (document, error) in
        if let document = document, document.exists {
            let my_post_list = document.get("my_post_list") as? [String] ?? []
//            print("Document data: \(saved_post_list)")
          completion(my_post_list)
        } else {
            print("Document does not exist")
        }
      }
      }
  //using it for mypost
  func fetchAllMyPosts(myPostArray: [String], completion: @escaping ([PostItem])->Void) {
    itemsWithMyPosts = []
    database.collection("Items").whereField("post_id", in: myPostArray).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let item_title = document.get("item_title") as? String ?? ""
              let item_description = document.get("item_description") as? String ?? ""
              let item_category = document.get("item_category") as? String ?? ""
              let item_buy = document.get("item_buy") as? Bool ?? false
              let condition = document.get("condition") as? String ?? ""
              let price = document.get("price") as? Double ?? 0
              let images = document.get("images") as? [String] ?? []
              let zip_code = document.get("zip_code") as? String ?? ""
              let delivery = document.get("delivery") as? Bool ?? false
              let pickup_location = document.get("pickup_location") as? String ?? ""
              self.fetchPostBasedOnPostId(postId: post_id) {(post) in
              self.itemsWithMyPosts.append(PostItem(postId: post_id, last_modified_timestamp: post.last_modified_timestamp, Availability: post.Availability, post_creation_date: post.post_creation_date, itemId: id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location,isSaved: false))

                completion(self.itemsWithMyPosts)
              }
              }
          }
      }
  }

  func fetchPostBasedOnPostId(postId:String ,completion: @escaping (Post)->Void)
  {
    self.database.collection("Posts").document(postId).getDocument() { (documentpost, error) in
          if let documentpost = documentpost, documentpost.exists {
            let last_modified_timestamp = Date(timeIntervalSinceReferenceDate: documentpost.get("last_modified_timestamp") as? TimeInterval ?? 0)
            let availability = documentpost.get("Availability") as? String ?? ""
            let post_creation_date = Date(timeIntervalSinceReferenceDate: documentpost.get("post_creation_date") as? TimeInterval ?? 0)
            let post = Post(id: postId, last_modified_timestamp: last_modified_timestamp, Availability: availability, post_creation_date: post_creation_date)
            completion(post)
          } else {
              print("Document does not exist")
        }
      }
  }

  func fetchUserByPostId(postId: String, completion: @escaping (MessageUser)->Void) {
    database.collection("Users").whereField("my_post_list", arrayContains: postId).getDocuments(){ (querySnapshot, err) in
      if let err = err {
          print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          let id = document.documentID
          let user_image = document.get("user_image") as? String ?? ""
          let first_name = document.get("first_name") as? String ?? ""
          let last_name = document.get("last_name") as? String ?? ""
          let user_status = document.get("user_status") as? Bool ?? true
          let messageUser = MessageUser(id: id, user_image: user_image, first_name: first_name, last_name: last_name, user_status: user_status)
          completion(messageUser)
          }
      }
    }
  }

  func updateHasUnreadMessagesStatus(chatId:String, completion: @escaping ()->Void) {
    database.collection("Chat").document(chatId).updateData([
      "hasUnreadMessage": false
    ])
    completion()
  }

  func UpdateChatWithNewMessage(chat:Chat, message:Message, completion: @escaping (Message)->Void) {
    if(chat.messages.count == 0){
      self.addMessage(message: message) { messageId in
        let newChat = SaveChat(id: chat.id, user1: chat.user1.id, user2: chat.user2.id, messages: [messageId], hasUnreadMessage: true)
        self.database.collection("Chat").document(newChat.id).setData(newChat.dictionary)
        completion(message)
      }
    }
    else{
      self.addMessage(message: message) { messageId in
        self.database.collection("Chat").document(chat.id).updateData([
          "messages": FieldValue.arrayUnion([messageId]),
          "hasUnreadMessage": true
      ])
        completion(message)
      }
    }
  }

  func addMessage(message:Message, completion: @escaping (String)->Void) {
    database.collection("Messages").document(message.id).setData(message.dictionary)
    completion(message.id)
  }

  func fetchChats(currentUserID:String, completion: @escaping ([Chat])->Void) {
    let auth = Auth.auth()
    var chats:[Chat] = []
    var chatCount = 0
    database.collection("Chat").addSnapshotListener{ (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
          self.fetchCountOfChats(currentUserId: auth.currentUser!.uid){result in
            chatCount = result
            if(chatCount == 0){
              completion(chats)
            }
            for document in querySnapshot!.documents {
              let id = document.documentID
              var user1_id = document.get("user1") as? String ?? ""
              var user2_id:String = ""
              if(user1_id == auth.currentUser?.uid){
                user2_id = document.get("user2") as? String ?? ""
              }
              else{
                user2_id = user1_id
                user1_id = document.get("user2") as? String ?? ""
              }
              if(user1_id == auth.currentUser?.uid){
                var user1:MessageUser = MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: true)
                var user2:MessageUser = MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: true)
                var messages:[Message] = []
                let messageIdArr = document.get("messages") as? [String] ?? []
                var hasUnreadMessage = document.get("hasUnreadMessage") as? Bool ?? false
                self.fetchMessageUser(userId: user1_id){result in
                  user1 = result
                  self.fetchMessageUser(userId: user2_id){result in
                    user2 = result
                    self.fetchMessages(messageIds: messageIdArr){results in
//                      print("incoming messages")
                      messages =  results.sorted(by: {
                        return $0.date <= $1.date
                      })
                      if(messages.last?.type == .Sent)
                      {
                        hasUnreadMessage = false
                      }
                      if(chats.filter({existingChat in return existingChat.id == id}).count > 0)
                      {
                        var index = -3
                        index = chats.firstIndex(where: { $0.id == id })!
                        let updatedChat = [Chat(id: id, user1: user1, user2: user2, messages: messages, hasUnreadMessage: hasUnreadMessage)]
                        chats.replaceSubrange(index...index, with: updatedChat)
                        completion(chats)
                      }
                      else{
                        chats.append(Chat(id: id, user1: user1, user2: user2, messages: messages, hasUnreadMessage: hasUnreadMessage))
                        completion(chats)
                      }
//                      if(chatCount == chats.count){
//                        completion(chats)
//                      }
                    }
                  }
                }
              }
            }
          }
        }
    }
  }

  func fetchCountOfChats(currentUserId:String, completion: @escaping (Int)->Void) {
    var countOfChats = 0
      database.collection("Chat").whereField("user1", isEqualTo: currentUserId).getDocuments(){(querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
          countOfChats = querySnapshot?.count ?? 0
          self.database.collection("Chat").whereField("user2", isEqualTo: currentUserId).getDocuments(){(querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                countOfChats = countOfChats + (querySnapshot?.count ?? 0)
                completion(countOfChats)
            }
          }
      }
    }
  }

  func fetchMessages(messageIds:[String],completion: @escaping ([Message])->Void) {
    let auth = Auth.auth()
    var messages:[Message] = []

    for messageId in messageIds{
      database.collection("Messages").document(messageId).addSnapshotListener{ (document, error) in
        if let document = document, document.exists {
          let id = document.documentID
          let date_number = document.get("date") as? TimeInterval ?? 0
          let date = Date(timeIntervalSinceReferenceDate: date_number)
          let from_user_id = document.get("from_user_id") as? String ?? ""
          let type:Message.MessageType = (from_user_id == auth.currentUser?.uid ? .Sent:.Received)
          let text = document.get("text") as? String ?? ""
          messages.append(Message(id: id, date: date, from_user_id: from_user_id, text: text, type: type))
        } else {
            print("Document does not exist")
        }
        if(messages.count == messageIds.count){
          completion(messages)
        }
      }
    }
  }
  
//  func fetchMessagesForChatView(chatId:String,completion: @escaping ([Message])->Void) {
//    let auth = Auth.auth()
//    var messages:[Message] = []
//    var messageIdArr:[String] = []
//    database.collection("Chat").document(chatId).addSnapshotListener{(document, error) in
//      if let document = document, document.exists {
//        messageIdArr = document.get("messages") as? [String] ?? []
//      } else {
//          print("Document does not exist")
//      }
//      if(messageIdArr.count > 0){
//        for messageId in messageIdArr{
//          self.database.collection("Messages").document(messageId).addSnapshotListener{ (document, error) in
//            if let document = document, document.exists {
//              let id = document.documentID
//              let date_number = document.get("date") as? TimeInterval ?? 0
//              let date = Date(timeIntervalSinceReferenceDate: date_number)
//              let from_user_id = document.get("from_user_id") as? String ?? ""
//              let type:Message.MessageType = (from_user_id == auth.currentUser?.uid ? .Sent:.Received)
//              let text = document.get("text") as? String ?? ""
//              print(text)
//              messages.append(Message(id: id, date: date, from_user_id: from_user_id, text: text, type: type))
//              completion(messages)
//            } else {
//                print("Document does not exist")
//            }
////            if(messages.count == messageIdArr.count){
////              completion(messages)
////            }
//          }
//        }
//      }
//      else{
//        completion(messages)
//      }
//    }
//  }

  func fetchMessageUser(userId:String, completion: @escaping (MessageUser)-> Void) {
    database.collection("Users").document(userId).getDocument{ (document, error) in
      if let document = document, document.exists {
        let id = document.documentID
        let user_image = document.get("user_image") as? String ?? ""
        let first_name = document.get("first_name") as? String ?? ""
//        print(first_name)
        let last_name = document.get("last_name") as? String ?? ""
        let user_status = document.get("user_status") as? Bool ?? true
        let user = MessageUser(id: id, user_image: user_image, first_name: first_name, last_name: last_name, user_status: user_status)
        completion(user)
//          let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//          print("Document data: \(dataDescription)")
      } else {
          print("Document does not exist")
      }
  }
  }


//  func fetchAllNotification() {
//    print("fetching notifications")
//    database.collection("Notifications").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//              let id = document.documentID
//              let user_id = document.get("user_id") as? String ?? ""
//              let sequence = document.get("sequence") as? [String] ?? [""]
//              let notification_on = document.get("notification_on") as? Bool  ?? false
//              let saved_post_change_alert = document.get("saved_post_change_alert") as? Bool  ?? false
//
//              self.notifications.append(Notification(id: id, user_id: user_id, notification_on: notification_on, saved_post_change_alert: saved_post_change_alert, sequence: sequence))
//            //      print("\(document.documentID) => \(document.data())")
//            }
//          for notification in self.notifications{
//            print(notification)
//          }
//        print("Notifications printed")
//        }
//    }
//  }

//  func fetchAllNotification_Sequence() {
//    print("fetching notification sequences")
//    database.collection("Notification_Sequences").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//              let id = document.documentID
//              let post_id = document.get("post_id") as? String ?? ""
//              let timestamp_notf = document.get("timestamp_notf") as? Date ?? Date()
//              let content = document.get("content") as? String ?? ""
//
//              self.notification_sequences.append(Notification_Sequence(id: id, post_id: post_id, timestamp_notf: timestamp_notf, content: content))
////                print("\(document.documentID) => \(document.data())")
//            }
//          for notification in self.notification_sequences{
//            print(notification)
//          }
//        print("Notification Sequences printed")
//      }
//    }
//  }
}
