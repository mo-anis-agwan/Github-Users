//
//  UserDetailViewController.swift
//  Testing-Project
//
//  Created by Anis on 11/05/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    //MARK:- IBOutlets
    @IBOutlet weak var userProfleImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var profileURL: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var siteAdminLabel: UILabel!
    
    @IBOutlet weak var reposURL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let user = user {
            configureDetails(user)
        }
    }
    

    func configureDetails(_ user: User) {
        
        userNameLabel.text = user.login
        idLabel.text = "\(user.id)"
        loginNameLabel.text = user.login
        profileURL.text = user.html_url
        reposURL.text = user.repos_url
        typeLabel.text = user.type
        if (user.site_admin) {
            siteAdminLabel.text = "Yes"
        } else {
            siteAdminLabel.text = "No"
        }
        
        if let url = URL(string: user.avatar_url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.userProfleImage.image = UIImage(data: data!)
                }
            }
        }
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
