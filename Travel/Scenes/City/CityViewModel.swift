//
//  CityViewModel.swift
//  Travel
//
//  Created by 김성민 on 7/9/24.
//

import Foundation

final class CityViewModel {
    
    // MARK: - Input
    // 세그먼트 선택
    var inputSegmentValueChanged = Observable(0)
    // 서치바 검색
//    var inputSearchBarTextDidChange: Observable<String?> = Observable("")
    
    // MARK: - Output
    var outputSelectedList = Observable(CityInfo.city)
    
    init() {
        inputSegmentValueChanged.bind { _ in
            self.setSelectedList()
        }
    }
    
    private func setSelectedList() {
        switch inputSegmentValueChanged.value {
        case 0:
            outputSelectedList.value = CityInfo.city
        case 1:
            outputSelectedList.value = CityInfo.city.filter { $0.domestic_travel }
        case 2:
            outputSelectedList.value = CityInfo.city.filter { !$0.domestic_travel }
        default:
            break
        }
    }
}
