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
    
    let list: [City] = CityInfo.city
    lazy var selectedList: [City] = list
    
    let viewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        
        configureSearchBar()
        configureSegment()
        configureTableView()
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
        setSelectedList()
        tableView.reloadData()
        
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
    
    func setSelectedList() {
        switch segment.selectedSegmentIndex {
        case 0:
            selectedList = list
        case 1:
            selectedList = list.filter { $0.domestic_travel }
        case 2:
            selectedList = list.filter { !$0.domestic_travel }
        default:
            break
        }
    }
    
    func search(searchText: String) {
        let searchText = searchText.uppercased()
        setSelectedList()
        selectedList = selectedList.filter {
            $0.city_name.uppercased().contains(searchText) ||
            $0.city_english_name.uppercased().contains(searchText) ||
            $0.city_explain.uppercased().contains(searchText)
        }
        tableView.reloadData()
    }
    
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        
        let data = selectedList[indexPath.row]
        cell.configureCell(data: data)
        
        cell.selectionStyle = .none
        return cell
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        search(searchText: searchText)
        // 키보드 내리기
        searchBar.resignFirstResponder()
    }
    
    // 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText: searchText)
    }
    
}
