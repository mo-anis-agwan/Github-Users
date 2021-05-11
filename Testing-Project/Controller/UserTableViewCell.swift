//
//  UserTableViewCell.swift
//  Testing-Project
//
//  Created by Anis on 10/05/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(user: User) {
        userName.text = user.login
        idLabel.text = "id: \(user.id)"
        if let url = URL(string: user.avatar_url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.userImage.image = UIImage(data: data!)
                }
            }
        }
    }
    
}
