//
//  ViewController.swift
//  hws-07-WhitehousePetitions
//
//  Created by Philip Hayes on 6/22/20.
//  Copyright © 2020 PhilipHayes. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Data Source", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(promptForFilter))

        // access We the People petitions from whitehouse.gov
        if navigationController?.tabBarItem.tag == 0 {
            // get the first 100 petitions
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        else {
            // get the first 100 petitions which have at least 10,000 signatures
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        // download petition data. this will run on the main thread and lock the UI until data is loaded
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading petitions, please check connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Data Source", message: "We the People \n petitions are downloaded from petitions.whitehouse.gov", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func promptForFilter() {
        let ac = UIAlertController(title: "Filter", message: "Enter a string to filter, blank to clear filter", preferredStyle: .alert)
        ac.addTextField()
        
        let submitFilter = UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.filteredPetitions.removeAll(keepingCapacity: true)
            self?.filter(filter)
            }
        
        ac.addAction(submitFilter)
        present(ac, animated: true)
    }
    
    func filter(_ filter: String) {
        let lowerFilter = filter.lowercased()
        
        for petition in petitions {
            let lowerPetitionTitle = petition.title.lowercased()
            let lowerPetitionBody = petition.body.lowercased()
            
            if lowerPetitionTitle.contains(lowerFilter) || lowerPetitionBody.contains(lowerFilter) {
                filteredPetitions.append(petition)
            }
        }
        
        tableView.reloadData()
    }
}

