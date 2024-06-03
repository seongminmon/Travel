//
//  ChatViewController.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    var data: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi()
        configureView()
        configureTableView()
    }
    
    func configureNavi() {
        navigationItem.title = data?.chatroomName ?? "익명"
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    func configureView() {
        textField.delegate = self
        textField.placeholder = "메세지를 입력하세요"
        
        sendButton.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        sendButton.tintColor = .lightGray
        sendButton.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag

        var xib = UINib(nibName: ChatTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: ChatTableViewCell.identifier)
        xib = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        
        // 스크롤 맨 밑으로 이동하기
        if let data {
            let indexPath = IndexPath(row: data.chatList.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func backButtonTapped() {
        // 화면 이동
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendButtonTapped() {
        //
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data?.chatList[indexPath.row] else { return UITableViewCell() }
        
        if data.user == .user {
            // 나의 채팅
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as! MyChatTableViewCell
            cell.configureCell(data)
            cell.selectionStyle = .none
            return cell
        } else {
            // 상대 채팅
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
            cell.configureCell(data)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    
}
