//
//  EstacionarmeController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit
import MobileCoreServices

class EstacionarmeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UIPopoverPresentationControllerDelegate , CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var user = 1
    var jData:NSDictionary!
    var distancia:Float!
    var c = 0
    var cellTake :ECell!
    var controller: UIImagePickerController?
    let picker = UIImagePickerController()
    var img:UIImage!
    var imagen:UIImage!
    var theImage: UIImage!

    
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var tf_public: UITextField!
    @IBOutlet weak var tb_timeLine: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        distancia = Float(prefs.integerForKey("Distance"))
        
        if let data = prefs.objectForKey("JDATA") as? NSDictionary{
            jData = data
            for i in data{
                c++
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self

        
        tb_timeLine.delegate = self
        tb_timeLine.dataSource = self
        tb_timeLine.showsVerticalScrollIndicator = false
        tb_timeLine.separatorColor = UIColor.clearColor()
        tb_timeLine.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        configureTextField([tf_public])
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self,
            selector: "handleKeyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)

        
    }
    
    
    
    func handleKeyboardWillHide(sender: NSNotification){
        if(tf_public.text != ""){
            sendMsj(tf_public.text)
            tf_public.text = ""
            tb_timeLine.reloadData()
        }
        self.view.frame.origin.y = 0
        
        
    }
    
    
    func handleKeyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y = -270
       // tb_timeLine.frame.height = 40 as CGFloat
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var not = jData["noticia_\(indexPath.row)"] as NSDictionary
        let cell = tb_timeLine.dequeueReusableCellWithIdentifier("ECell") as ECell
        cell.selectionStyle = .None
        cell.setCell(not["mensaje"] as NSString)
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    func configureTextField(texto: [UITextField]){
        
        var leftPaddingView:UIView!
        for a in texto {
            leftPaddingView  = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            leftPaddingView.backgroundColor = UIColor.clearColor()
            a.leftView = leftPaddingView
            a.leftViewMode = .Always
            a.delegate = self
        }
        for b in texto{
            b.layer.borderColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1).CGColor
            b.layer.borderWidth = 1
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    @IBAction func back(sender: UIButton) {
        //dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destinationViewController as UIViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
  

    func sendMsj(msj:String){
        let location = locationManager.location
        var d = CLLocationDistance(distancia)
        var r = (distancia/1000.0)
        
        var post:NSString = "latitud=\(location.coordinate.latitude)&longitud=\(location.coordinate.longitude)&distancia=\(r)&usuario=\(user)&mensaje=\"\(msj)\""
        
        NSLog("PostData: %@",post);
        
        var url:NSURL = NSURL(string:"http://clipp.mx/estacionate/setNoticia.php")!
        
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
                    jData = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    var c = 0
                    
                }
                
            }
            
            println(post)
        }
    }
    
    
    @IBAction func takePhoto(sender: UIButton) {
        //self.iniciarFoto()
        //cellTake()
    }
    
    
   /* func imageWasSavedSuccessfully(image: UIImage,
        didFinishSavingWithError error: NSError!,
        context: UnsafeMutablePointer<()>){
            
            if let theError = error{
                println("An error happened while saving the image = \(theError)")
            } else {
                cellImg.iv_user.image = image
                println("Image was saved successfully")
            }
    }
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    let stringType = type as String
                    
                    if stringType == kUTTypeImage as NSString{
                        
                        
                        
                        if picker.allowsEditing{
                            theImage = info[UIImagePickerControllerEditedImage] as UIImage
                        } else {
                            theImage = info[UIImagePickerControllerOriginalImage] as UIImage
                        }
                        
                        
                        let selectorAsString =
                        "imageWasSavedSuccessfully:didFinishSavingWithError:context:"
                        
                        let selectorToCall = Selector(selectorAsString)
                        
                        UIImageWriteToSavedPhotosAlbum(theImage,
                            self,
                            selectorToCall,
                            nil)
                        
                        cellImg.iv_user.image = theImage
                        img = theImage
                    }
                    
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
        println("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    func iniciarFoto(){
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
                theController.mediaTypes = [kUTTypeImage as NSString]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            println("Camera is not available")
        }
        
    }
    
    //Picker
    
    func library(){
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        let chosenImage = editingInfo [UIImagePickerControllerOriginalImage] as UIImage
        cellImg.iv_user.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }*/

    
   
}

