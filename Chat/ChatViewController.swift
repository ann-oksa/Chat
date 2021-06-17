//
//  ChatViewController.swift
//  Chat
//
//  Created by Anna Oksanichenko on 10.06.2021.
//

import UIKit


class ChatViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgTextview: UITextView!
    
    var test = ["one", "two", "three", "four"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: ChatTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        msgTextview.delegate = self
        msgTextview.isScrollEnabled = false
        
        self.title = "Chat"
        //        tableView.estimatedRowHeight = UITableView.automaticDimension
        //        tableView.rowHeight = UITableView.automaticDimension
        registerForKeyboardNotifications()
    }
    deinit {
        deregisterFromKeyboardNotifications()
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func adjustUITextViewHeight(arg : UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseIdentifier, for: indexPath) as! ChatTableViewCell
        cell.fill(text: test[indexPath.row], index: indexPath.row)
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 84.0
    //    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
}

extension ChatViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            guard let newMsg = textView.text else {
                return false
            }
            test.append(newMsg)
            textView.text = ""
            tableView.reloadData()
            scrollToBottom()
            return false
        }
        return true
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //    @objc
    //    func keyboardWillShown(notification: NSNotification) {
    //        guard let info = notification.userInfo,
    //              let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
    //            return
    //        }
    //
    //        let currentScrollHeight = keyboardSize.height
    //        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: currentScrollHeight, right: 0.0)
    //        self.scrollView.contentInset = contentInsets
    //        self.scrollView.scrollIndicatorInsets = contentInsets
    //
    //    }
    //
    //    @objc
    //    func keyboardWillBeHidden(notification: NSNotification) {
    //        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //        self.scrollView.contentInset = contentInsets
    //        self.scrollView.scrollIndicatorInsets = contentInsets
    //    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.test.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

