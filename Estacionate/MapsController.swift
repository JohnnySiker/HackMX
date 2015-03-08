//
//  MapsController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class MapsController: UIViewController,GMSMapViewDelegate, CLLocationManagerDelegate {
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

    
    @IBOutlet weak var map: GMSMapView!
    var marker:GMSMarker!
    var camera:GMSCameraPosition!
    @IBOutlet weak var btn_estacionarme: UIButton!
    @IBOutlet weak var btn_toggleMenu: UIButton!
    
    var circle:GMSCircle!
    var circleCenter:CLLocationCoordinate2D!
    var distancia:Double!
    let locationManager = CLLocationManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(btn_toggleMenu)
        distancia = Double(prefs.integerForKey("Distance"))
        
        if(distancia == 0.0){
            distancia = 500.0
        }
        
        self.navigationController?.navigationBar.hidden = true

        self.view.bringSubviewToFront(btn_estacionarme)
        self.view.bringSubviewToFront(btn_toggleMenu)
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
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            map.myLocationEnabled = true
            map.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            map.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines as [String]
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
        
        var d = CLLocationDistance(distancia)
        var r = (distancia/1000.0)
        dibujaGeoCerca(location.coordinate.latitude, lon: location.coordinate.longitude, radio:d)
        
        var post:NSString = "latitud=\(location.coordinate.latitude)&longitud=\(location.coordinate.longitude)&distancia=\(r)"
        
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
                        var type = (jData["tipo"] as NSString).integerValue
                        println(lat)
                        println(lon)
                        let coord = CLLocationCoordinate2D(latitude: lat,longitude: lon)
                        dibujaMarcador(coord, tipo: type)
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
       
        
        switch tipo {
        case 1:
            marker.position = position
            marker.title = "Estacionamiento público"
            marker.snippet = ""
            marker.icon = UIImage(named: "estacionamiento.png")
            break
        case 2:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "autopartes.png")
            break
        case 3:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "bote.png")
            break
        case 4:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "franelero.png")
            break
        case 5:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "grua.png")
            break
        case 6:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "araña")
            break
        case 7:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "noestacionarse.png")
            break
        case 8:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "parquimetro.png")
            break
        case 9:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "reservados.png")
            break
        case 10:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "robo.png")
            break
        case 11:
            marker.position = position
            marker.title = "Hack CDMX"
            marker.snippet = "Clipp"
            marker.icon = UIImage(named: "vandalismo.png")
            break
        default:
            break
        }
       
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
  
    
    @IBAction func menu() {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }

    @IBAction func estacionarce() {
        requestEstacionar()
    }
    
    func requestEstacionar(){
        var location = locationManager.location
        
        var d = CLLocationDistance(distancia)
        var r = (distancia/1000.0)
        
        var post:NSString = "latitud=\(location.coordinate.latitude)&longitud=\(location.coordinate.longitude)&distancia=\(r)&usuario=1"
        
        NSLog("PostData: %@",post);
        
        var url:NSURL = NSURL(string:"http://clipp.mx/estacionate/estacionar.php")!
        
        var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        var postLength:NSString = String( postData.length )
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
        
        println("urldata \(urlData)")
        
        if ( urlData != nil ) {
            let res = response as NSHTTPURLResponse!;
            
            NSLog("Response code: %ld", res.statusCode);
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                var responseData:NSString = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                NSLog("Response ==> %@", responseData);
                
                var error: NSError?
                
                if !(responseData.isEqualToString("[]")){
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    prefs.setObject(jsonData, forKey: "JDATA")
                    
                    
                    /*for i in jsonData{
                    let jData = jsonData["noticia_\(c)"] as NSDictionary
                    
                    var tipo = (jData["tipo"] as NSString).integerValue
                    var id = (jData["id"] as NSString).integerValue
                    var msj = (jData["mensaje"] as NSString)
                    var lat = (jData["latitud"] as NSString).doubleValue
                    var lon = (jData["longitud"] as NSString).doubleValue
                    var fecha = (jData["fecha"] as NSString)
                    
                    println("Latitud: \(lat)")
                    println("Longitud: \(lon)")
                    println("Tipo: \(tipo)")
                    println("ID: \(id)")
                    println("Mensaje: \(msj)")
                    println("Fecha: \(fecha)")
                    
                    }*/
                    
                    
                }
                
            }
            
        }
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("Estacionarme") as EstacionarmeController
        self.presentViewController(nView, animated: true, completion: nil)
    }
   
}
