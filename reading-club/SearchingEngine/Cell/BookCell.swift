//
//  BookCell.swift
//  reading-club
//
//  Created by Agata on 12.08.2022.
//

import Foundation
import UIKit
import SDWebImage

protocol BookCellViewModel {
    var coverUrlString : String? {get}
    var bookName: String {get}
    var bookAuthor: [String] {get}
}

class BookCell: UITableViewCell { //не забыть привязать этот класс к интерфесу через identity inspector
    
    static let reuseId = "BookCell"
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() { //эта функция будет вызываться только если мы хотим конфигурировать ячейку через xib, а мы для этого и создали интерфейс файл
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
    }
    
    func set(viewModel: BookCellViewModel) {
        bookNameLabel.text = viewModel.bookName
        bookAuthorLabel.text = viewModel.bookAuthor.joined(separator: ", ") //потому что апиха выдает нам массив, а нам нужен просто текст
        
        guard let url = URL(string: viewModel.coverUrlString ?? "") else { return }
        bookImageView.sd_setImage(with: url, completed: nil)
}
}
