//
//  Router.swift
//  Foodly
//
//  Created by Decagon on 6/5/21.
//

import Foundation
import FirebaseFirestore

typealias Parameter = [String: Any]
typealias NetworkRouterCompletion =  (Result<QuerySnapshot?, Error>) -> Void

class Router<T: FirestoreRequest>: FireBaseRouter {
    
    func request(_ request: T, completion: @escaping NetworkRouterCompletion) {
        switch request.tasks {
        case .create(let data):
            return create(request, documentData: data, completion: completion)
        case .update(let data):
            return update(request, documentData: data, completion: completion)
        case .read :
            return read(request, completion: completion)
        case .delete :
            return delete(request, completion: completion)
        case .qread(let type) :
            return qread(request, type: type, completion: completion)
        }
    }
    
    private func read (_ request: T, completion: @escaping NetworkRouterCompletion) {
        request.collectionReference?.addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(snapshot))
            }
        }
    }
    
    private func qread (_ request: T, type: String, completion: @escaping NetworkRouterCompletion) {
        request.collectionReferences?.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(snapshot))
            }
        }
    }
    
    private func create(_ request: FirestoreRequest, documentData: Parameter,
                        completion: @escaping NetworkRouterCompletion) {
        request.collectionReference?.addDocument(data: documentData) { error  in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    private func delete (_ request: FirestoreRequest, completion: @escaping NetworkRouterCompletion) {
        request.documentReference?.delete { ( error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    private func update(_ request: FirestoreRequest, documentData: Parameter,
                        completion: @escaping NetworkRouterCompletion) {
        request.documentReference?.setData(documentData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
}
