//
//  MasterViewController.swift
//  TLI Test
//
//  Created by Murali Gorantla on 19/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var detailViewController: DetailViewController? = nil
    var objects = [News]()

    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureActivityIndicatorView()
        registerNib()
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        requestArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper
    
    func configureActivityIndicatorView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func registerNib() -> Void {
        let nib = UINib.init(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    // MARK:- Server Calls
    
    func requestArticles() {
        spinner.startAnimating()
        DataManager.shared.requestMostPopularArticles(online: true, parameters: [:]) { [weak self](news, error) in
            guard let strongSelf = self else {
                return
            }
            if (error != nil) {
                strongSelf.showAlert(title: "Message", message: (error?.getErrorMessage())!)
            } else {
                strongSelf.objects = news
                strongSelf.tableView.reloadData()
            }
            strongSelf.spinner.stopAnimating()
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View datasource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell
        let object = objects[indexPath.row]
        cell.detailItem = object
        return cell
    }
    
    // MARK: - Table View Delagte Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }

}

