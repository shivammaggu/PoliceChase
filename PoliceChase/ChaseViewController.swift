//
//  ChaseViewController.swift
//  PoliceChase
//
//  Created by Shivam on 24/01/24.
//

import UIKit

class ChaseViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect.zero
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(ChaseTableViewCell.self,
                      forCellWithReuseIdentifier: ChaseTableViewCell.reuseId)
        return view
    }()
    
    private lazy var reGenButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Regenerate", for: .normal)
        return button
    }()
    
    var row: Int?
    var column: Int?
    
    var cellCount: Int {
        ((self.row ?? 0) * (self.column ?? 0))
    }
    
    let ghost = "👻"
    let police = "👮🏼"
    
    var randomPosGhost: Int = 0
    
    var randomPosPolice: Int = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        self.randomPosGhost = Int.random(in: 0..<self.cellCount)
        self.randomPosPolice = self.findPolice()
    }
    
    func findPolice() -> Int {
        let ghostRow = self.randomPosGhost / 10
        let ghostCol = self.randomPosGhost % 10
        
        
        var random = stride(from: ghostRow * 10, through: ((ghostRow + 1) * 10 - 1), by: 1)
        var random2 = stride(from: ghostCol, through: <#T##Strideable#>, by: <#T##Comparable & SignedNumeric#>)
        
        print(random)
        print(random2)
        let polRow =
        let polCol = random % 10
        
        return random
    }
    
    func setupUI() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.reGenButton)
        
        self.reGenButton.addTarget(self, action: #selector(regen), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.reGenButton.widthAnchor.constraint(equalToConstant: 100),
            self.reGenButton.heightAnchor.constraint(equalToConstant: 50),
            self.reGenButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.reGenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func regen() {
        self.randomPosGhost = Int.random(in: 0..<self.cellCount)
        self.randomPosPolice = self.findPolice()
    }
}

extension ChaseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChaseTableViewCell.reuseId,
                                                            for: indexPath) as? ChaseTableViewCell else {
            return UICollectionViewCell()
        }
        
        var showText: String
        
        if indexPath.row == self.randomPosGhost {
            showText = ghost
        } else if indexPath.row == randomPosPolice {
            showText = police
        } else {
            showText = ""
        }
        
        cell.setupCell(showText, color: .red)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (self.view.window?.windowScene?.windows.first?.bounds.width ?? 0) / (CGFloat((self.column ?? 0)) * 1.0) - 2
        return CGSize(width: side, height: side)
    }
}
