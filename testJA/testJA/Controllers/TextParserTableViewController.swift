//
//  TextParserTableViewController.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class TextParserTableViewController : UITableViewController {
    
    private var model : [(key: Character, value: Int)] = [] {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private lazy var headerView : UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Generate Text", for: .normal)
        button.titleLabel?.font = UIFont(name: "TimesNewRoman", size: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.clipsToBounds = true
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(generatePressed))
        button.addGestureRecognizer(recognizer)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        ApiEchoPresence.authToken = nil
        performSegue(withIdentifier: "LogInSegue", sender: self)
    }
    
    @objc func generatePressed() {
        
        DispatchQueue.global(qos: .background).async {
            
            let string = Networking.apiEchoPresence.getText()
            self.parseResult(for: string)
        }
    }
}

extension TextParserTableViewController {
    
    func parseResult(for string: String) {
        
        var newModel : [Character : Int] = [:]
        
        string.forEach { (char) in
            
            if newModel[char] != nil {
                newModel[char]! += 1
            } else {
                newModel[char] = 1
            }
        }
        
        model = newModel.sorted { $0.value < $1.value }
    }
}

extension TextParserTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let info = model[indexPath.row]
        
        cell.textLabel?.text = """
        Character '\(info.key)' appears \(info.value) \(info.value > 1 ? "times" : "time")
        """
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

extension TextParserTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}




