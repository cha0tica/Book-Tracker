//
//  BookSearchViewController.swift
//  reading-club
//
//  Created by Agata on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BookSearchDisplayLogic: class {
  func displayData(viewModel: BookSearch.Model.ViewModel.ViewModelData)
}

class BookSearchViewController: UIViewController, BookSearchDisplayLogic {

  var interactor: BookSearchBusinessLogic?
  var router: (NSObjectProtocol & BookSearchRoutingLogic)?

    @IBOutlet weak var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil) //объявляем на будущее
    private var searchViewModel = SearchViewModel.init(cells: [])
    private var timer: Timer?
    
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = BookSearchInteractor()
    let presenter             = BookSearchPresenter()
    let router                = BookSearchRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup() //благодаря этому методу все со всеми общаются
      
    setupSearchBar() //включаем поиск
    setupTableView() //вызываем таблицу
  }
  
    private func setupSearchBar() { //создаем функцию для полоски поиска сверху. надо вставить его в навигейшн бар
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false //чтобы поиск показывался сразу, а не хз когда
        searchController.obscuresBackgroundDuringPresentation = false //экран не будет затемняться, когда мы что-то вводим в серч баре
        searchController.searchBar.delegate = self //чтобы срабатывала функция, когда мы ввводим текст, надо активировать экстеншн, который мы снизу сделали
    }
    
    private func setupTableView() { //регистрируем таблицу
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        let nib = UINib(nibName: "BookCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: BookCell.reuseId)
        table.tableFooterView = UIView() //выкинули пречью-ячейки
    }
    
  func displayData(viewModel: BookSearch.Model.ViewModel.ViewModelData) {
      switch viewModel {
          
      case .some:
          print ("viewController .some")
      case .displayBooks(let searchViewModel):
          print ("viewController .displayBooks")
          self.searchViewModel = searchViewModel
          table.reloadData()
      }
  }
  
}

extension BookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count //будет столько ячеек, сколько результатов поиска
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: BookCell.reuseId, for: indexPath) as! BookCell
        let cellViewModel = searchViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        
//        cell.textLabel?.text = "\(cellViewModel.bookName)\n\(cellViewModel.bookAuthor)"
//        cell.textLabel?.numberOfLines = 2
//        cell.imageView?.image = UIImage(systemName: "photo")!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 //эта функция устанавливает константную высоту ячейки 
    }
    
    //этот кусочек для подсказки
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 4
        label.text = "Это страничка поиска книги. \n Введи свой запрос \n в строке поиска выше, \n чтобы найти, что почитать."
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cells.count > 0 ? 0 : 100 //если количество ячеек больше 0, то высота хэдера будет 0, иначе 150
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let book = searchViewModel.cells[indexPath.row] //searchViewModel.cells - весь массив. indexPath.row - конкретная книга - book
//        present(ReadingNow(book: book), animated: true, completion: nil)
//    }
}

extension BookSearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText) //textDidChange - пользователь ввел текст
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.interactor?.makeRequest(request: BookSearch.Model.Request.RequestType.getBooks(searchTerm: searchText)) //после ввода текста мы обращаемся к файлу BookSearchInteractor, который будет с этим текстом что-то делать
        })
    }
}
