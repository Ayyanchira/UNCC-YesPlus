//
//  QuotesViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/1/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class QuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rootReference = Database.database().reference()
    var quotes:[Quote] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToNewQuoteView), name: .quotes, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: .quoteRefresh, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchQuotes()
    }

    //MARK:- Table view delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTableViewCell
        cell.quoteTextView.text = quotes[indexPath.row].quote
        cell.authorTextLabel.text = quotes[indexPath.row].author
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return appDelegate.isAdmin
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if appDelegate.isAdmin{
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
                self.deleteQuoteAt(indexPath: indexPath)
            }
            return [deleteAction]
        }else{
            return nil
        }
        
    }
    
    func deleteQuoteAt(indexPath:IndexPath) {
        let quoteToDelete = quotes[indexPath.row]
        let quoteReference = rootReference.child("allQuotes").child(quoteToDelete.key)
        quoteReference.removeValue { (error, dbRef) in
            self.fetchQuotes()
        }
    }
    
    func fetchQuotes() {
        let quoteReference = rootReference.child("allQuotes")
        quoteReference.observeSingleEvent(of: .value) { (snapshot) in
            if let values = snapshot.value as? NSDictionary{
                self.quotes.removeAll()
                for key in values.allKeys{
                    let quoteObject = values[key] as? [String:Any]
                    let quoteString = quoteObject!["quote"] as! String
                    let author = quoteObject!["author"] as! String
                    let key = key as! String
                    
                    let quote = Quote(quote: quoteString, author: author, key:key)
                    self.quotes.append(quote)
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    @objc func navigateToNewQuoteView() {
        performSegue(withIdentifier: "newQuote", sender: nil)
    }
    
    @objc func refreshTableView() {
        print("Quotes refreshing...")
        fetchQuotes()
    }
}
