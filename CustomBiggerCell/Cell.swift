//
//  Cell.swift
//  CustomBiggerCell
//
//  Created by Fu Jim on 2021/3/31.
//

import UIKit

class Cell: UICollectionViewCell {
    
    let gender = UILabel()
    let name = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        preSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        preSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func preSetup() {
        contentView.addSubview(gender)
        gender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gender.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gender.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10)
        ])
        
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: +10)
        ])
    }
    
    func setup(data: ViewController.Person) {
        gender.text = data.gender.rawValue
        gender.font = UIFont.systemFont(ofSize: 10)
        name.text = data.name
        name.font = UIFont.systemFont(ofSize: 10)
    }
    
    func large() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    func normal() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
            self.layer.borderWidth = 0
        }
    }
}
