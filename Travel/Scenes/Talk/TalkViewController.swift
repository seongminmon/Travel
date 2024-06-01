//
//  TalkViewController.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class TalkViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var list = ChatRoom.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        searchBar.placeholder = "친구 이름을 검색해보세요"
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 80
        
        let xib = UINib(nibName: TalkTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TalkTableViewCell.identifier)
    }
}

extension TalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkTableViewCell.identifier, for: indexPath) as! TalkTableViewCell
        
        let data = list[indexPath.row]
        cell.configureCell(data)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: ChatViewController.identifier) as! ChatViewController
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
