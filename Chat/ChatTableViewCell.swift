//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Anna Oksanichenko on 18.06.2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    static let reuseIdentifier = "ChatTableViewCell"
    static let nibName = reuseIdentifier

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(text: String, index: Int) {
        accountImage.image = index % 2 == 0 ? UIImage(named: "cat") : UIImage(named: "dog")
        nameLabel.text = index % 2 == 0 ? "Kate" : "Tony"
        messageLabel.text = text

    }
    
}
