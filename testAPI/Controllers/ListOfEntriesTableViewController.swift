//
//  ListOfEntriesTableViewController.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import UIKit

final class ListOfEntriesTableViewController: UITableViewController {
    
    fileprivate let networkDataFetcher = NetworkDataFetcher()
    fileprivate var getEntries : GetEntries?
    fileprivate var entry : String?
    
    override func viewWillAppear(_ animated: Bool) {
        Reachability.isConnectedToNetwork { (isConnected) in
            if isConnected {
                checkSession()
            } else {
                lostConnect()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkSession(){
        if UserDefaults.standard.string(forKey: "session") != nil{
            getEntries(session : UserDefaults.standard.string(forKey: "session")!)
        }else{
            newSession()
            guard UserDefaults.standard.string(forKey: "session") != nil else { return }
            getEntries(session : UserDefaults.standard.string(forKey: "session")!)
        }
    }
    
    func newSession(){
        self.networkDataFetcher.fetchSession(httpBody : "a=new_session") { (getNewSession) in
            guard let getNewSession = getNewSession else { return }
            UserDefaults.standard.set(getNewSession.data?.session, forKey: "session")
        }
    }
    
    func getEntries(session : String){
        self.networkDataFetcher.fetchEntry(httpBody : "a=get_entries&session=\(session)") { (getEntries) in
            guard let getEntries = getEntries else { return }
                self.getEntries = getEntries
                self.tableView.reloadData()
        }
    }
    
    @IBAction func createEntry(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ListToCreateSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ListToViewSegue"{
            let navVC = segue.destination as! ViewFullEntryViewController
            navVC.entry = entry
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getEntries?.data![0].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListOfEntriesTableViewCell
        
        let str = getEntries?.data![0][indexPath.row].body
        let nsString = str! as NSString
        if nsString.length > 0
        {
            cell.entryLabel.text = nsString.substring(with: NSRange(location: 0, length: nsString.length > 200 ? 200 : nsString.length))
        }
        cell.daLabel.text = getEntries?.data![0][indexPath.row].da
        cell.dmLabel.text = getEntries?.data![0][indexPath.row].dm
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        entry = getEntries?.data![0][indexPath.row].body
        performSegue(withIdentifier: "ListToViewSegue", sender: nil)
    }
    
}

extension ListOfEntriesTableViewController{
    
    func lostConnect(){
        let alert = UIAlertController(title: "Ошибка", message: "Отсутствует соединение с сервером!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Обновить данные", style: UIAlertAction.Style.default, handler: { action in
            self.checkSession()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(errorMessage : String){
        let alert = UIAlertController(title: "Ошибка", message: "\(errorMessage)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
}
