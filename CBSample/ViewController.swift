//
//  ViewController.swift
//  CBSample
//
//  Created by Galileo Guzman on 08/12/22.
//

import UIKit


class ViewController: UIViewController {
    
    var viewModel = BluetoothViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Bluetooth devices"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.peripheralsDidChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.peripheralNames.count > 0 {
            return viewModel.peripheralNames.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?
                
        cell?.textLabel?.text = viewModel.peripheralNames[indexPath.row]
                
        return cell!
    }
}
