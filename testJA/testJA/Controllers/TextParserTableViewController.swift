//
//  TextParserTableViewController.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class TextParserTableViewController : UITableViewController {
    
    lazy var headerView : UIButton = {
        
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
    
    @objc func generatePressed() {
        
        print("Generate Pressed")
    }
}

extension TextParserTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        
        cell.textLabel?.text = "lol"
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
        return 5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}




