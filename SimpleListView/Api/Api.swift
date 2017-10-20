//
//  Api.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import Foundation
import Alamofire

enum RequestResult {
    case sucsess(result: Any)
    case fail
}

typealias RequestCompletion = (RequestResult) -> ()

class Api {
    
    private init() {}
    
    private struct Constants {
        private init(){}
        static let getCategoriesURLString = "http://www.bluger.ch/envision/api/get_categories"
        static let postPacksURLString     = "http://www.bluger.ch/envision/api/get_packs"
        struct parameters {
            static let categoryID = "categoryID"
        }
    }
    
    static func getCategories(completion: @escaping RequestCompletion) {
        Alamofire.request(Constants.getCategoriesURLString).responseJSON { response in
            guard let value = response.result.value as? Dictionary<String, Any> else {
                completion(.fail)
                return
            }
            guard let categoriesDicts = value["data"] as?  [[String : Any]] else {
                completion(.fail)
                return
            }
            let categories = ApiSerialization.categoriesFrom(categoriesData: categoriesDicts)
            completion(.sucsess(result: categories))
        }
    }
    
    static func getPacks(forID categoryID: String, completion: @escaping RequestCompletion) {
        let params: Parameters = [Constants.parameters.categoryID : categoryID]
        Alamofire
            .request(Constants.postPacksURLString, method: .post, parameters: params)
            .responseJSON { response in
                guard let value = response.result.value as? Dictionary<String, Any>
                    else {
                        completion(.fail)
                        return
                }
                guard let packDicts = value["data"] as?  [[String : Any]] else {
                    completion(.fail)
                    return
                }
                let packs = ApiSerialization.packsFrom(packsdata: packDicts)
                completion(.sucsess(result: packs))
        }
    }
    
}

private class ApiSerialization {
    
    private init() {}
    
    static func categoriesFrom(categoriesData: [Dictionary<String, Any>]) -> [Category] {
        var categories: [Category] = []
        for categoryData in categoriesData {
            if let category = Category(dict: categoryData) {
                categories.append(category)
            }
        }
        return categories
    }
    
    static func packsFrom(packsdata: [Dictionary<String, Any>]) -> [Pack] {
        var packs: [Pack] = []
        for packData in packsdata {
            if let pack = Pack(dict: packData) {
                packs.append(pack)
            }
        }
        return packs
    }
    
}
