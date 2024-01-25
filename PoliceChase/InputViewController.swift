//
//  ViewController.swift
//  PoliceChase
//
//  Created by Shivam on 24/01/24.
//

import UIKit

class InputViewController: UIViewController {
    
    @IBOutlet weak var rowsField: UITextField!
    @IBOutlet weak var columnsField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI() {
        self.title = "Provide Input"
        self.generateButton.isEnabled = true
        self.generateButton.tintColor = .white
        self.generateButton.backgroundColor = .blue
    }
    
    func getIntValue(_ s: String) -> Int {
        return Int(s) ?? 0
    }
    
    func validate(_ row: Int, _ col: Int) -> Bool {
        return row >= 2 && row <= 20 && col >= 2 && col <= 20
    }
    
    @IBAction func generate(_ sender: Any) {
        let row = self.getIntValue(self.rowsField.text ?? "")
        let col = self.getIntValue(self.columnsField.text ?? "")
        
        guard self.validate(row, col) else { return }
        
        let viewModel = ChaseViewModel(row: row, column: col)
        let viewController = ChaseViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
