//
//  ViewController.swift
//  PoliceChase
//
//  Created by Shivam on 24/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rowsField: UITextField!
    @IBOutlet weak var columnsField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.generateButton.isEnabled = true
        self.generateButton.tintColor = .white
    }

    @IBAction func generate(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "ChaseViewController") as? ChaseViewController else { return }
        let vc = ChaseViewController()
        
        if let row = self.rowsField.text, let col = self.columnsField.text {
            vc.row = Int(row)
            vc.column = Int(col)
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
