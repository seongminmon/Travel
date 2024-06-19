//
//  RestaurantMapViewController.swift
//  Travel
//
//  Created by 김성민 on 5/30/24.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let totalList = RestaurantList.restaurantArray
    var koreanList: [Restaurant] = []
    var etcList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        koreanList = totalList.filter { $0.category == "한식" }
        etcList = totalList.filter { $0.category != "한식" }
        
        setupNavi()
        setupMapView()
        
        locationManager.delegate = self
        checkDeviceLocationAuthorization()
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
        let center = totalList.randomElement()!.location
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        // 처음 어노테이션은 전체 선택
        makeAnnotation(totalList)
    }
    
    func makeAnnotation(_ selectedList: [Restaurant]) {
        // 모든 어노테이션 삭제
        mapView.removeAnnotations(mapView.annotations)
        
        // 선택된 리스트에서 어노테이션 추가
        for item in selectedList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.location
            annotation.title = item.name
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension RestaurantMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect annotation: any MKAnnotation) {
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    }
}

extension RestaurantMapViewController {
    
    // iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            print("사용자의 위치 권한 상태 확인")
            let status = locationManager.authorizationStatus
            checkCurrentLocationAuthorization(status)
        } else {
            print("위치 서비스가 꺼져 있어서 권한 요청 불가능 -> 설정으로 이동")
        }
    }
    
    func checkCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: // 아직 선택 안함
            print("아직 선택 안함 -> 위치 권한 묻기")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .denied: // 허용 안함
            print("권한 허용 안함 -> 설정으로 이동")
            
        case .authorizedWhenInUse: // 앱 사용중 허용함
            print("앱 사용중 허용함 -> 위치 정보 가져오기")
            locationManager.startUpdatingLocation()
            
        default:
            print("ERROR")
        }
    }
    
}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
    }
    
    // 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 사용자의 권한 상태가 바뀔 때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
}
