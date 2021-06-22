//
//  ChatViewController.swift
//  Chat
//
//  Created by Anna Oksanichenko on 10.06.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var test = ["one", "labeljernfwejrnrvkjern bjvkqberkjvbnefkjbn vkejrbvlkjeknjehb qefljhbvqelj rbvljherbnvjlheqbrvjbenr;clv efwbv rkbcv;kjwkdb nv;qbrwkfbq;wrkbfq;krw bv;kbf;kvcjbqrewkjqejbfngkwerh vbweiprbhvipfhbpivhgpiw iprtbgpweijrtnjvnwefinwpeir", "index % 2 == 0 ?", "four", "five", "siiiix"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: ChatTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
       
        tableView.estimatedSectionFooterHeight = 70.0
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 84.0
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Chat"
        registerForKeyboardNotifications()
        
        //Option 1
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        customView.backgroundColor = UIColor.red
//        let msgTextview = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 25))
//        msgTextview.backgroundColor = .green
//        msgTextview.delegate = self
//        msgTextview.font = UIFont.systemFont(ofSize: 19.0)
//        msgTextview.isScrollEnabled = false
//       // msgTextview.translatesAutoresizingMaskIntoConstraints = false
//        customView.addSubview(msgTextview)
//        tableView.tableFooterView = customView

    }
    deinit {
        deregisterFromKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            tableView.reloadData()
        }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
   
    func adjustUITextViewHeight(arg : UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = false
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseIdentifier, for: indexPath) as! ChatTableViewCell
        let message = test[indexPath.row]
        cell.fill(text: message, index: indexPath.row)
        return cell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        print("est")
        return 70.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let custom = UIView()
        custom.backgroundColor = .brown
        let msgTextview  = UITextView()
        msgTextview.backgroundColor = .green
        msgTextview.delegate = self
        msgTextview.font = UIFont.systemFont(ofSize: 20.0)
        msgTextview.translatesAutoresizingMaskIntoConstraints = false
        msgTextview.isScrollEnabled = false
        custom.addSubview(msgTextview)

        msgTextview.leadingAnchor.constraint(equalTo: custom.leadingAnchor).isActive = true
        msgTextview.trailingAnchor.constraint(equalTo: custom.trailingAnchor).isActive = true
        msgTextview.topAnchor.constraint(equalTo: custom.topAnchor).isActive = true
        msgTextview.bottomAnchor.constraint(equalTo: custom.bottomAnchor).isActive = true

        return custom
    }

}

extension ChatViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" && text.contains("\n") {
            guard let newMsg = textView.text else {
                print("cant identifite msg")
                return false
            }
            test.append(newMsg)
            print(newMsg)
            textView.text = ""

            tableView.reloadData()
            scrollToBottom()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.isScrollEnabled = false
        print(textView.bounds.height)
        tableView.reloadData()
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.test.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
        @objc
        func keyboardWillShown(notification: NSNotification) {
            print("shown")
            guard let info = notification.userInfo,
                  let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue.size else {
                print("return")
                return
            }
            
            let currentScrollHeight = keyboardSize.height
            print(currentScrollHeight)
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: currentScrollHeight, right: 0.0)
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
            print("content insets")
        }
    
        @objc
        func keyboardWillBeHidden(notification: NSNotification) {
            let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }
}

