//
//  ViewController.swift
//  TravelBook
//
//  Created by Rusen Topcu on 4.02.2020.
//  Copyright © 2020 Rusen Topcu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: - Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Object create for Location info request
    var location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        location.delegate = self
        //Lokasyonun keskinlik ayarı
        location.desiredAccuracy = kCLLocationAccuracyBest
        //Kullanıcıdan konum bilgisinin ne zaman alınacağı
        location.requestWhenInUseAuthorization()
        //Kullanıcının yerini almaya başlamak için
        location.startUpdatingLocation()
    }
    
    //MARK: - Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        var span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        var region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

}
