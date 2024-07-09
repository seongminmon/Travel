//
//  CityViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    let viewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        
        configureSearchBar()
        configureSegment()
        configureTableView()
        bindData()
    }
    
    func bindData() {
        viewModel.outputSelectedList.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "도시를 검색해보세요"
    }
    
    func configureSegment() {
        segment.addTarget(
            self,
            action: #selector(segmentValueChanged),
            for: .valueChanged
        )
    }
    
    @objc func segmentValueChanged(sender: UISegmentedControl) {
        viewModel.inputSegmentValueChanged.value = sender.selectedSegmentIndex
        
        searchBar.text = ""
        view.endEditing(true)
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        let xib = UINib(nibName: CityCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: CityCell.identifier)
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputSelectedList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        
        let data = viewModel.outputSelectedList.value[indexPath.row]
        cell.configureCell(data: data)
        
        cell.selectionStyle = .none
        return cell
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 키보드 내리기
        searchBar.resignFirstResponder()
    }
    
    // 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchBarTextDidChange.value = searchText
    }
    
}
