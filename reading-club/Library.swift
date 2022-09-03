//
//  Library.swift
//  reading-club
//
//  Created by Agata on 04.08.2022.
//

import Foundation
import UIKit
import Alamofire

class Library: UITableViewController {
    
    var networkService = NetworkService()
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil) //объявляем на будущее
    
    var bookList = [Item]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        setupSearchBar() // включаем поиск
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")

        }
    private func setupSearchBar() { //создаем функцию для полоски поиска сверху. надо вставить его в навигейшн бар
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false //чтобы поиск показывался сразу, а не хз когда
        searchController.searchBar.delegate = self //чтобы срабатывала функция, когда мы ввводим текст, надо активировать экстеншн, который мы снизу сделали
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //функция, определяющая количество ячеек
        //return 5 //пока поставили 5
        return bookList.count //теперь делаем столько ячеек, сколько элементов в массиве
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //тут конкретно с ячейками работаем
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) //пока просто cellId
        //cell.textLabel?.text = "indexPath: \(indexPath)" //пока впишем какую нибудь фигню, чтобы видеть ячейки
        
        let book = bookList[indexPath.row] //создаем ячейку книги, которая обращается к конкретной книге в массиве книг по номеру
        
        
        cell.textLabel?.text = "\(book.volumeInfo.title)\n\(book.volumeInfo.authors)" //создаем выше книгу
        cell.textLabel?.numberOfLines = 2 //у нас две строчки - под автора и под название, так что устанавиваем значение на 2
        cell.imageView?.image = UIImage(systemName: "photo")!
        return cell
    }
    
    }

extension Library: UISearchBarDelegate { //это для того, чтобы поиск правильно работал
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { //функция, которая отвечает за то, чтобы что-то происходило, когда мы вводим текст в серч бар. она вылезла по textDidChange
        //print(searchText)
        
        timer?.invalidate()//валидируем таймер
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchBooks(searchText: searchText) { [weak self] (searchResults) in
                self?.bookList = searchResults?.items ?? []
                self?.tableView.reloadData()
            }
            
        })
        
        
    }
}
