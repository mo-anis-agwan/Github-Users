//
//  UserTableViewController.swift
//  Testing-Project
//
//  Created by Anis on 10/05/21.
//

import UIKit

class UserTableViewController: UITableViewController {

    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers(since: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell

        // Configure the cell...
        let user = users[indexPath.row]
        
        cell.configure(user: user)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
                
        let detailView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailStoryboard") as! UserDetailViewController
        detailView.user = users[indexPath.row]
        detailView.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(detailView, animated: true)
        //self.present(detailView, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = users.count - 1
        if indexPath.row == lastItem {
            getUsers(since: lastItem)
        }
    }
    
    
    //MARK:- Helper Functions
    
    var users: [User] = []
    private func getUsers(since: Int, per_page: Int=20) {
        guard let url = URL(string: "https://api.github.com/users?since=\(since)&per_page=\(per_page)") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print(error!)
            }
            
            if data != nil {
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode([User].self, from: data!)
                        for doc in decodedData {
                            self.users.append(doc)
                        }
                        self.tableView.reloadData()
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}
