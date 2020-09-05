//
//  CreateEntryViewController.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import UIKit

final class CreateEntryViewController: UIViewController, UITextViewDelegate {
    
    fileprivate var networkDataFetcher = NetworkDataFetcher()
    fileprivate var getAddEntry : GetAddEntry?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          textView.delegate = self
          textView.frame = self.view.bounds
          var topCorrect : CGFloat = (self.view.frame.height / 2) - (textView.contentSize.height / 2)
          topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
          textView.contentInset = UIEdgeInsets(top: topCorrect,left: 0,bottom: 0,right: 0)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboard(notification:Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{ return }
        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
            self.view.frame.origin.y = -keyboardReact.height
        }else{
            self.view.frame.origin.y = 0
        }
    }

    func createEntry(session: String, body : String){
        
        self.networkDataFetcher.fetchCreateEntry(httpBody : "a=add_entry&session=\(session)&body=\(body)") { (getAddEntry) in
            guard let getAddEntry = getAddEntry else { return }
            self.getAddEntry = getAddEntry
        }
        
    }
    
    @IBAction func saveEntry(_ sender: UIButton) {
        
        createEntry(session: UserDefaults.standard.string(forKey: "session")!, body: "\(textView.text!)")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func closeEntry(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateEntryViewController{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
