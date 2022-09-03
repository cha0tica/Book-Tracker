//
//  Network.swift
//  reading-club
//
//  Created by Agata on 08.08.2022.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchBooks(searchText: String, competion: @escaping (Books?) -> Void){
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(searchText)&key=AIzaSyARH1SYyEFq_I_XtdxCX3HznDOCY0g_SGE".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(url).response { (dataResponse) in
            if dataResponse.error != nil {
                print ("We have some problems: \(String(describing: dataResponse.error))")
                competion(nil)
                return
            }
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder() //создаем декодер
            do { //здесь мы пытаемся декодировать данные
                let objects = try decoder.decode(Books.self, from: data)
                print(objects)
                competion(objects)
                
            } catch let jsonError { //здесь мы справляемся с ошибками, если они пришли
                print("Failed to decode", jsonError)
                competion(nil)
            }
            
            //let someString = String(data: data, encoding: .utf8)
            //print(someString ?? "")
        }
    }
}
