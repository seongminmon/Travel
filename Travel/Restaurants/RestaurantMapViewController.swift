//
//  RestaurantMapViewController.swift
//  Travel
//
//  Created by 김성민 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let totalList = RestaurantList.restaurantArray
    var koreanList: [Restaurant] = []
    var etcList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        koreanList = totalList.filter { $0.category == "한식" }
        etcList = totalList.filter { $0.category != "한식" }
        
        setupNavi()
        setupMapView()
    }
    
    func setupNavi() {
        navigationItem.title = "식당 지도"
        
        let filterButton = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filterButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let all = UIAlertAction(title: "전체", style: .default) { [weak self] _ in
            print("전체 클릭")
            self?.makeAnnotation(self?.totalList ?? [])
        }
        let korean = UIAlertAction(title: "한식", style: .default) { [weak self] _ in
            print("한식 클릭")
            self?.makeAnnotation(self?.koreanList ?? [])
        }
        let etc = UIAlertAction(title: "기타", style: .default) { [weak self] _ in
            print("기타 클릭")
            self?.makeAnnotation(self?.etcList ?? [])
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(all)
        alert.addAction(korean)
        alert.addAction(etc)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func setupMapView() {
        mapView.delegate = self
        
        // 처음 위치는 모든 식당 중 랜덤
        let start = totalList.randomElement()!
        let center = CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        // 처음 어노테이션은 전체 선택
        makeAnnotation(totalList)
    }
    
    func makeAnnotation(_ selectedList: [Restaurant]) {
        
        // 모든 어노테이션 삭제
        mapView.removeAnnotations(mapView.annotations)
        
        // 선택된 리스트에서 어노테이션 추가
        for item in selectedList {
            let location = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = item.name
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension RestaurantMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect annotation: any MKAnnotation) {
//        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(#function)
    }
}
