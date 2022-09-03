//
//  BookSearchInteractor.swift
//  reading-club
//
//  Created by Agata on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BookSearchBusinessLogic {
    func makeRequest(request: BookSearch.Model.Request.RequestType)
}

class BookSearchInteractor: BookSearchBusinessLogic {
    
    var networkService = NetworkService() //надо вытащить сюда нашу работу с текстом
    var presenter: BookSearchPresentationLogic?
    var service: BookSearchService?
    
    func makeRequest(request: BookSearch.Model.Request.RequestType) {
        if service == nil {
            service = BookSearchService()
        }
        
        switch request { //пользователь ввел текст и мы на основе его запрашиваем сетевые данные или данные из баз данных
        case .some:
            print("interactor .some")
        case .getBooks (let seatchTerm):
            print("interactor .getBooks")
            networkService.fetchBooks(searchText: seatchTerm) { [weak self]  (searchResponse) in //в данном случае запрашиваем данные из сети с помощью вот этой переменной
                self?.presenter?.presentData(response: BookSearch.Model.Response.ResponseType.presentBooks(searchResponse: searchResponse)) //тут мы попросили данные из интернета и передали их в презентер. когда мы к нему обращаемся, мы переходим в файл BookSearchPresenter. презентер обрабаывает полученные нами данные так, как нужно вью контроллеру.
            }
            
        }
        
        
    }
    
}
