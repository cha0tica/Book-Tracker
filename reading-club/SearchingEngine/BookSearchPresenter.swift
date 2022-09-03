//
//  BookSearchPresenter.swift
//  reading-club
//
//  Created by Agata on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BookSearchPresentationLogic {
  func presentData(response: BookSearch.Model.Response.ResponseType)
}

class BookSearchPresenter: BookSearchPresentationLogic {
  weak var viewController: BookSearchDisplayLogic?
  
  func presentData(response: BookSearch.Model.Response.ResponseType) {
  
      switch response {
          
      case .some:
          print ("presenter .some")
      case .presentBooks (let searchResults): //let - это входной параметр. сам презентер отвечает за подготовку данных для отображения, поэтому он потом отдаем все во вью контроллер
          let cells = searchResults?.items.map ({ (book) in
              cellViewModel(from: book)
          }) ?? []
          print ("presenter .presentBooks")
          let searchViewModel = SearchViewModel.init(cells: cells)
          
          viewController?.displayData(viewModel: BookSearch.Model.ViewModel.ViewModelData.displayBooks(searchViewModel: searchViewModel)) //уходим во viewController
      }
      
  }
  
    private func cellViewModel(from book: Item) -> SearchViewModel.Cell{
        return SearchViewModel.Cell.init(coverUrlString: book.volumeInfo.imageLinks?.thumbnail,
                                         bookName: book.volumeInfo.title,
                                         bookAuthor: book.volumeInfo.authors)
    }
}
