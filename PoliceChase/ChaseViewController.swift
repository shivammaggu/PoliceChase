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
        button.addTarget(self, action: #selector(regen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Regenerate", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let viewModel: ChaseViewModel
    
    init(viewModel: ChaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        self.viewModel.findGhostPosition()
        self.viewModel.findPolicePosition()
    }
    
    func setupUI() {
        self.title = "Let's Chase"
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.reGenButton)
        
        self.reGenButton.isEnabled = true
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.reGenButton.widthAnchor.constraint(equalToConstant: 100),
            self.reGenButton.heightAnchor.constraint(equalToConstant: 50),
            self.reGenButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -50),
            self.reGenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func regen() {
        self.reGenButton.isEnabled = false
        self.reGenButton.backgroundColor = .gray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.findGhostPosition()
            self.viewModel.findPolicePosition()
            self.reGenButton.isEnabled = true
            self.reGenButton.backgroundColor = .blue
            self.collectionView.reloadData()
        }
    }
}

extension ChaseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cellCount
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
        
        if indexPath.row == self.viewModel.randomPosGhost {
            showText = ChaseViewModel.ghost
        } else if indexPath.row == self.viewModel.randomPosPolice {
            showText = ChaseViewModel.police
        } else {
            showText = ""
        }
        
        cell.setupCell(showText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (self.view.window?.windowScene?.windows.first?.bounds.width ?? 0) / (CGFloat(self.viewModel.column) * 1.0) - 2
        return CGSize(width: side, height: side)
    }
}
