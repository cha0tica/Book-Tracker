//
//  BookSearchModels.swift
//  reading-club
//
//  Created by Agata on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum BookSearch {
   
  enum Model {
    struct Request { //тут мы что-то ищем в интернете
      enum RequestType {
        case some
          case getBooks(searchTerm: String) //передаем запрос из строки поиска
      }
    }
    struct Response {
      enum ResponseType {
        case some
          case presentBooks(searchResponse: Books?) //данные, с которыми будет работать этот презентер. они опциональные, так как могут и не придти
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
          case displayBooks(searchViewModel: SearchViewModel)
      }
    }
  }
  
}

struct SearchViewModel {
    struct Cell: BookCellViewModel {
        var coverUrlString : String?
        var bookName: String
        var bookAuthor: [String]
    }
    
    let cells: [Cell]
}
