//
//  APIConfigs.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class APIConfigs {
    static let shared = APIConfigs()
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let firebaseUser = result?.user {
                let user = Profile(uid: firebaseUser.uid, userName: "", email: firebaseUser.email ?? "")
                completion(.success(user))
            }
        }
    }

    func signUp(withEmail email: String, password: String, name: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            guard let firebaseUser = authResult?.user else {
                completion(.failure(error!))
                return
            }

            let changeRequest = firebaseUser.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let user = Profile(uid: firebaseUser.uid, userName: name, email: firebaseUser.email ?? "")

                    // Save user's name and email to Firestore
                    let userDocument = self.db.collection("users").document(firebaseUser.uid)
                    userDocument.setData([
                        "name": name,
                        "email": email,
                    ]) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(user))
                        }
                    }
                }
            }
        }
    }

    
    func getUserData(userId: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let data = document.data()
                let name = data?["name"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                let user = Profile(uid: userId, userName: name, email: email)
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    func getUserName(completion: @escaping (String?) -> Void) {
        guard let userId = APIConfigs.shared.currentUserId else {
            completion(nil)
            return
        }

        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let userName = dataDescription?["name"] as? String
                completion(userName)
            } else {
                print("Document does not exist")
                completion(nil)
            }
        }
    }
    
    func updateUserProfile(userId: String, name: String? = nil, completion: @escaping (Result<Void, Error>) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        if let name = name {
            changeRequest?.displayName = name
        }
        
        changeRequest?.commitChanges(completion: { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                var dataToUpdate: [String: Any] = [:]
                if let name = name {
                    dataToUpdate["name"] = name
                }
                
                if !dataToUpdate.isEmpty {
                    self?.db.collection("users").document(userId).updateData(dataToUpdate) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } else {
                    completion(.success(()))
                }
            }
        })
    }
    
    func postMovieIdea(title: String, description: String, coverImageUrl: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserId = self.currentUserId else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }
        
        getUserName { [weak self] (userName) in
            guard let userName = userName else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Username not found."])))
                return
            }

            let movieData = [
                "title": title,
                "description": description,
                "coverImageUrl": coverImageUrl,
                "author": userName,
                "authorUserId": currentUserId
            ]

            self?.db.collection("movieIdeas").addDocument(data: movieData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    func deleteMovieIdea(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !movie.documentId.isEmpty else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Movie ID not found."])))
            return
        }

        guard let currentUserId = self.currentUserId, currentUserId == movie.authorUserId else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not authorized to delete this movie."])))
            return
        }

        db.collection("movieIdeas").document(movie.documentId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func getMovieIdeas(completion: @escaping (Result<[Movie], Error>) -> Void) {
        db.collection("movieIdeas").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                var movieIdeas = [Movie]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let coverImageUrl = data["coverImageUrl"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let authorId = data["authorUserId"] as? String ?? ""
                    
                    let movieIdea = Movie(title: title, description: description, image: coverImageUrl, author: author, authorUserId: authorId, documentId: document.documentID)
                    movieIdeas.append(movieIdea)
                }
                completion(.success(movieIdeas))
            }
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let imageName = UUID().uuidString
        let imageData = image.jpegData(compressionQuality: 0.8)!
        let storageRef = storage.reference().child("chatImages").child("\(imageName).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
    
    var currentUserId: String? {
         return Auth.auth().currentUser?.uid
     }
}
