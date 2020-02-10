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
import CoreData

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: - Variables
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    var chosenTitle = ""
    var chosenTitleId: UUID?
    
    //MARK: - Outlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    
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
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(choosenLocation(gesturerecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if chosenTitle != "" {
             //Core Data
            
            
        }
        
        
    }
    
    @objc func choosenLocation(gesturerecognizer:UILongPressGestureRecognizer) {
        
        if gesturerecognizer.state == .began {
            
            let touchedPoint = gesturerecognizer.location(in: self.mapView)
            let touchedCoordinate = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            choosenLatitude = touchedCoordinate.latitude
            choosenLatitude = touchedCoordinate.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
        }
        
    }
    


    
    //MARK: - Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        var span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: contex)
        
        //MARK: -  Attributes
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(choosenLatitude, forKey: "latitude")
        newPlace.setValue(choosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try contex.save()
            print("success")
        }
        catch {
            print("error")
        }
        
    }
    
}

