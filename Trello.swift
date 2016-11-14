//
//  Trello.swift
//  Trello
//
//  Created by Events on 11/12/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class TrelloAPI {

    static let sharedInstance = TrelloAPI()
    
    let apiKey = "fdd1a7304887d0ca6979640385aa3ba3"
    let token = "bdce674f6f32a3249e3b36401c6b2a552f442ef770d37d3f62bb21c1759b9ee9"
    var id_num = ""

    let testCard = "5820e5c35b7778b1317e7a97"
    let testBoard = "5820e5c35b7778b1317e7a8c"
    let testList = "5820e5c35b7778b1317e7a8d"


    class URls {
        let apiKey = "fdd1a7304887d0ca6979640385aa3ba3"
        let token = "bdce674f6f32a3249e3b36401c6b2a552f442ef770d37d3f62bb21c1759b9ee9"
        var id_num = ""
        var cardURL: String = ""
        var boardURL: String = ""
        var listURL: String = ""
        var memberURL: String = ""
        var createURL: String = ""
        var updateURL: String = ""
        required init(id_num: String) {
            self.id_num = id_num
            cardURL = "https://api.trello.com/1/cards/" + id_num + "?fields=name,idList,desc&member_fields=fullName&key=" + apiKey + "&token=" + token
            boardURL = "https://api.trello.com/1/boards/" + id_num + "?lists=open&list_fields=name&fields=name,desc&key=" + apiKey + "&token=" + token
            listURL = "https://api.trello.com/1/lists/" + id_num + "?fields=name&cards=open&card_fields=name,desc&key=" + apiKey + "&token=" + token
            memberURL = "https://api.trello.com/1/members/me?fields=username,fullName,url&boards=all&board_fields=name&organizations=all&organization_fields=displayName&key=" + apiKey + "&token=" + token

        }
        
        required init(var name: String, var desc: String, id_list: String) {
            desc = desc.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            name = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            createURL = "https://api.trello.com/1/cards/?idList=" + id_list + "&name=" + name + "&desc=" + desc + "&key=" + apiKey + "&token=" + token
        }
        
        required init(id_num: String, var name: String, var desc: String, id_list: String) {
            desc = desc.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            name = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            updateURL = "https://api.trello.com/1/cards/" + id_num + "?idList=" + id_list + "&name=" + name + "&desc=" + desc + "&key=" + apiKey + "&token=" + token
        }
    }

    
// Example Board URL 		https://api.trello.com/1/boards/4eea4ffc91e31d1746000046?lists=open&list_fields=name&fields=name,desc&key=[application_key]&token=[optional_auth_token]

    func getTrelloMe(id_string: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: testBoard)
        let route = urls.memberURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getTrelloBoardById(id_string: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: id_string)
        let route = urls.boardURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getTrelloListById(id_string: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: id_string)
        let route = urls.listURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getTrelloCardById(id_string: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: id_string)
        let route = urls.cardURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
    private func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            request.HTTPBody = jsonBody
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
        }
    }
    
    func deleteTrelloCardById(id_string: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: id_string)
        let route = urls.cardURL
        makeHTTPDeleteRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPDeleteRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "DELETE"
        
        do {
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        }
    }

    func updateTrelloCardById(id_string: String, name: String, desc: String, id_list: String, onCompletion: (JSON) -> Void) {
        let urls = URls(id_num: id_string, name: name, desc: desc, id_list: id_list)
        let route = urls.updateURL
        makeHTTPPutRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPPutRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "PUT"
        
        do {
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        }
    }
    
    func createTrelloCard(name: String, desc: String, id_list: String, onCompletion: (JSON) -> Void) {
        let urls = URls(name: name, desc: desc, id_list: id_list)
        let escapedString = urls.createURL
        let route = escapedString
        makeHTTPPostRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPPostRequest(path: String, onCompletion: ServiceResponse) {
        print(path)
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            let session = NSURLSession.sharedSession()
            print("SessionLoaded")
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                print("checkingdata")
                if let jsonData = data {
                    print("sendbackdata")
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        }
    }
}
