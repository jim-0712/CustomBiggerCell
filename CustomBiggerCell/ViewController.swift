//
//  ViewController.swift
//  CustomBiggerCell
//
//  Created by Fu Jim on 2021/3/31.
//

import UIKit

class ViewController: UIViewController {
    
    enum Gender: String {
        case boy = "boy"
        case girl = "girl"
    }
    
    struct Person {
        let gender: Gender
        let name: String
    }
    
    var centerCell: Cell?
    
    let people: [Person] = [Person(gender: .boy, name: "Jim"),
                            Person(gender: .girl, name: "Irene"),
                            Person(gender: .boy, name: "Ray"),
                            Person(gender: .boy, name: "Ninn"),
                            Person(gender: .boy, name: "Rick"),
                            Person(gender: .boy, name: "Beth"),
                            Person(gender: .boy, name: "Jim"),
                            Person(gender: .girl, name: "Irene"),
                            Person(gender: .boy, name: "Ray"),
                            Person(gender: .boy, name: "Ninn"),
                            Person(gender: .boy, name: "Rick"),
                            Person(gender: .boy, name: "Beth")]
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Do any additional setup after loading the view.
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.setup(data: people[indexPath.row])
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        
        let centerPoint = CGPoint(x: self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: self.collectionView.frame.size.height / 2 + scrollView.contentOffset.y)
        
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint), self.centerCell == nil {
            // centerCell is instance variable of type: YourCell
            if let cell = self.collectionView.cellForItem(at: indexPath) as? Cell {
                self.centerCell = cell
                self.centerCell?.large()
            }
        }
        
        if let cell = self.centerCell { // center cell is global variable
            let offsetX = centerPoint.x - cell.center.x // get to current position of the cell
            if offsetX < -50 || offsetX > 50 {
                cell.normal()
                self.centerCell = nil
            }
        }
    }
}
