//
//  TabBar.swift
//  reading-club
//
//  Created by Agata on 04.08.2022.
//

import Foundation
import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3776089847, alpha: 1)
        
        let searchVC: BookSearchViewController = BookSearchViewController.loadFromStoryboard()
        let readingVC: ReadingNow = ReadingNow.loadFromStoryboard()

        viewControllers = [
            //это иконка с книгой
            generateViewController(rootViewController: readingVC, image: UIImage(systemName: "book")!, title: "Моя книга"), //конструкция image: UIImage(systemName: "book")! нужна для того, чтобы достать картинку из SF Symbols
            //это иконка с библиотекой
            generateViewController(rootViewController: searchVC, image: UIImage(systemName: "books.vertical")!, title: "Поиск книг")
            //можно будет по тому же принципу добавить еще кнопок
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image //это картинка для нижнего меню
        navigationVC.tabBarItem.title = title //это текст для нижнего меню
        rootViewController.navigationItem.title = title //это текст для верхнего меню
        navigationVC.navigationBar.prefersLargeTitles = true //это включение верхнего меню
        return navigationVC
    }
    }

