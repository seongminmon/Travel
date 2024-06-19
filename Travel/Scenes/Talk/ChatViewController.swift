//
//  ChatViewController.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    var data: ChatRoom?
    let placeholder = "메세지를 입력하세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi()
        configureView()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 테이블뷰 스크롤 맨 밑으로 이동하기
        if let data {
            let indexPath = IndexPath(row: data.chatList.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
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
        textView.delegate = self
        textView.text = placeholder
        textView.textColor = .lightGray
        
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        
        // 텍스트뷰 최대 줄 수 설정
        textView.textContainer.maximumNumberOfLines = 1
        textView.isScrollEnabled = true
        
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
        tableView.separatorStyle = .none

        var xib = UINib(nibName: ChatTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: ChatTableViewCell.identifier)
        xib = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: MyChatTableViewCell.identifier)
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

extension ChatViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //
    }
}
