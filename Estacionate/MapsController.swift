//
//  MapsController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class MapsController: UIViewController,GMSMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var map: GMSMapView!
    var marker:GMSMarker!
    var camera:GMSCameraPosition!
    
    var circle:GMSCircle!
    var circleCenter:CLLocationCoordinate2D!
    
    let locationManager = CLLocationManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self
        
        marker = GMSMarker()
        
        map.myLocationEnabled = true
        
        let location = locationManager.location
        
        println(location)
        
        camera = GMSCameraPosition.cameraWithLatitude(19.4410987, longitude: -99.1815764, zoom: 18, bearing: 30, viewingAngle: 40)
        
        marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        //Título de la etiqueta
        marker.title = "Hack CDMX"
        //Descripcion de la etiqueta
        marker.snippet = "Clipp"
       // marker.icon = UIImage(named: "ccar.png")
        
        map.camera = camera
        //marker.map = map
        
        
        circleCenter = CLLocationCoordinate2D(latitude: 19.3218135, longitude: -99.1862229)
        circle = GMSCircle(position: circleCenter, radius: 1000)
        circle.fillColor = UIColor(red: 61/255, green: 125/255, blue: 187/255, alpha: 0.5)
        circle.strokeColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        circle.strokeWidth = 5
        
        circle.map = map
        
        map.settings.myLocationButton = true
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        request()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        NSLog("You tapped at %f,%f", coordinate.latitude, coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 2
        if status == .AuthorizedWhenInUse {
            
            // 3
            locationManager.startUpdatingLocation()
            
            //4
            map.myLocationEnabled = true
            map.settings.myLocationButton = true
        }
    }
    
    // 5
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            
            // 6
            map.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 7
            locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines as [String]
                //self.adressLabel.text = join("\n", lines)
                
                // 4
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func request(){
        var location = locationManager.location
        
        var i = 1.0
        var r = (i*1000.0)
        dibujaGeoCerca(location.coordinate.latitude, lon: location.coordinate.longitude, radio:r)
        
        var post:NSString = "latitud=\(location.coordinate.latitude)&longitud=\(location.coordinate.longitude)&distancia=\(i)"
        
        NSLog("PostData: %@",post);
        
        var url:NSURL = NSURL(string:"http://www.estacionate.clipp.mx/items.php")!
        
        var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        var postLength:NSString = String( postData.length )
        
        var request:NSMutableURLRequest
        = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
        
        if ( urlData != nil ) {
            let res = response as NSHTTPURLResponse!;
            
            //NSLog("Response code: %ld", res.statusCode);
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                if !(responseData.isEqualToString("[]")){
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    var c = 0
                    
                    for i in jsonData{
                        let jData = jsonData["item_\(c)"] as NSDictionary
                        println("verbose")
                        var lat = (jData["latitud"] as NSString).doubleValue
                        var lon = (jData["longitud"] as NSString).doubleValue
                        println(lat)
                        println(lon)
                        let coord = CLLocationCoordinate2D(latitude: lat,longitude: lon)
                        dibujaMarcador(coord, tipo: 1)
                        //dibujaGeoCerca(lat, lon: lon, radio: 100)
                        c++
                    }
                    
                    println("fin")
                    println(c)
                }
                
            }
            
        }
    }
    
    func dibujaMarcador(position:CLLocationCoordinate2D,tipo:Int){
        var marker = GMSMarker()
        marker.position = position
        marker.title = "Hack CDMX"
        marker.snippet = "Clipp"
        marker.icon = UIImage(named: "ccar.png")
        marker.map = self.map
        
    }
    
    func dibujaGeoCerca(lat:CLLocationDegrees,lon:CLLocationDegrees,radio:CLLocationDistance){
        var circle = GMSCircle()
        var circleCenter = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        circle = GMSCircle(position: circleCenter, radius: radio)
        circle.fillColor = UIColor(red: 61/255, green: 125/255, blue: 187/255, alpha: 0.5)
        circle.strokeColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        circle.strokeWidth = 5
        
        circle.map = self.map
    }

    

   
}
