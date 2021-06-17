//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Anna Oksanichenko on 10.06.2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    static let reuseIdentifier = "ChatTableViewCell"
    static let nibName = reuseIdentifier
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.messageLabel.sizeToFit()
        self.messageLabel.numberOfLines = 0

    }
    func fill(text: String, index: Int) {
        profileImage.image = index % 2 == 0 ? UIImage(named: "cat") : UIImage(named: "dog")
        nameLabel.text = index % 2 == 0 ? "Kate" : "Luke"
        messageLabel.text = text

    }
    
}
