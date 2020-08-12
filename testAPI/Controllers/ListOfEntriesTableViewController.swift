//
//  ListOfEntriesTableViewController.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import UIKit


class ListOfEntriesTableViewController: UITableViewController {
    
    var getNewSession: GetNewSession?
    var getEntries : GetEntries?
    
    let networkDataFetcher = NetworkNewSession()
    let networkGetEntries = NetworkGetEntries()
    
    var entry : String?
    
    private let token = "rkomXHX-yr-Qxsnfn2"
    private let url = "https://bnet.i-partner.ru/testAPI/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Reachability.isConnectedToNetwork { (isConnected) in
            if isConnected {
               check()
            } else {
                alert()
            }
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Ошибка", message: "Отсутствует соединение с сервером!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Обновить данные", style: UIAlertAction.Style.default, handler: { action in

            self.check()

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func check(){
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "session") != nil{
            getEntries(session : UserDefaults.standard.string(forKey: "session")!)
            
        }else{
            newSession()
            guard UserDefaults.standard.string(forKey: "session") != nil else { return }
            getEntries(session : UserDefaults.standard.string(forKey: "session")!)
        }
    }
    
    func newSession(){
       
        self.networkDataFetcher.fetchSession(urlString: url , token : token) { (getNewSession) in
            guard let getNewSession = getNewSession else { return }
            self.getNewSession = getNewSession
            print("getNewSession",getNewSession.data.session)
            let defaults = UserDefaults.standard
            defaults.set(getNewSession.data.session, forKey: "session")
        }
    }
    
    func getEntries(session : String){

        self.networkGetEntries.fetchEntry(urlString: url , token : token , session : session) { (getEntries) in
            guard let getEntries = getEntries else { return }
            self.getEntries = getEntries
            self.tableView.reloadData()
            
        }
    }
    
    
    @IBAction func createEntry(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ListToCreateSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToCreateSegue"{
            let navVC = segue.destination as! CreateEntryViewController
            navVC.session = UserDefaults.standard.string(forKey: "session")
        }
        if segue.identifier == "ListToViewSegue"{
            let navVC = segue.destination as! ViewFullEntryViewController
            navVC.entry = entry
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return getEntries?.data[0].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListOfEntriesTableViewCell
        
        let str = getEntries?.data[0][indexPath.row].body
        let nsString = str! as NSString
        if nsString.length > 0
        {
            cell.entryLabel.text = nsString.substring(with: NSRange(location: 0, length: nsString.length > 200 ? 200 : nsString.length))
        }
        cell.daLabel.text = getEntries?.data[0][indexPath.row].da
        cell.dmLabel.text = getEntries?.data[0][indexPath.row].dm
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        entry = getEntries?.data[0][indexPath.row].body
        performSegue(withIdentifier: "ListToViewSegue", sender: nil)
    }
    
    
}
