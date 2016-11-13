//
//  Trello.swift
//  Trello
//
//  Created by Events on 11/12/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import Foundation

enum Item :String {
    case Card = "cards"
}

let apiKey = "fdd1a7304887d0ca6979640385aa3ba3"
let token = "bdce674f6f32a3249e3b36401c6b2a552f442ef770d37d3f62bb21c1759b9ee9"
var id_number = ""

let testCard = "5820e5c35b7778b1317e7a97"
let testBoard = "5820e5c35b7778b1317e7a8c"
let testList = "5820e5c35b7778b1317e7a8d"


struct TrelloAPI {
    
    private static let cardURL = "https://api.trello.com/1/cards/" + id_number + "?fields=name,idList,desc&member_fields=fullName&key=" + apiKey + "&token=" + token
    private static let boardURL = "https://api.trello.com/1/boards/" + id_number + "?lists=open&list_fields=name&fields=name,desc&key=" + apiKey + "&token=" + token
    private static let listURL = "https://api.trello.com/1/lists/" + id_number + "?fields=name&cards=open&card_fields=name&key=" + apiKey + "&token=" + token
    
}
// Example Board URL 		https://api.trello.com/1/boards/4eea4ffc91e31d1746000046?lists=open&list_fields=name&fields=name,desc&key=[application_key]&token=[optional_auth_token]

public func trelloBoardURL() -> String {
    let returnString = ""
    id_number = testBoard
    guard let url = NSURL(string: TrelloAPI.boardURL) else {
        print("Can not creat URL")
        return returnString
    }
    let urlRequest = NSURLRequest(URL: url)
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    
    let task = session.dataTaskWithRequest(urlRequest) {
        (data, response, error) in
        guard error == nil else {
            print("error calling GET on /todos/1")
            print(error)
            return
        }
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let todo = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the todo, let's just print it to prove we can access it
            print(todo)
            
            // the todo object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            //guard let todoTitle = todo["title"] as? String else {
            //   print("Could not get todo title from JSON")
            //    return
            //}
            //print("The title is: " + todoTitle)
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    
    task.resume()
    
    return returnString
}

