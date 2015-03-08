import UIKit
import MobileCoreServices


class MyMenuTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var selectedMenuItem : Int = 0
    var counter : Int = 0
    var controller: UIImagePickerController?
    let picker = UIImagePickerController()
    var cellImg:CustomMainCell!
    var img:UIImage!
    var imagen:UIImage!
    var theImage: UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollEnabled = false
        // let c = CustomMainCell()
        tableView.rowHeight = 600.0
        //tableView.allowsSelection = false
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        tableView.delegate = self
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row){
        case 0:
            cellImg = CustomMainCell()
            cellImg.selectionStyle = .None
            cellImg.setCell("yips.jpg", lbl_name:"Alejandro", lbl_last:"Zepeda",ranking:"Ranking: 57.4")
            return cellImg
        case 1:
            var cell = ViewCustomCell()
            cell.selectionStyle = .None
            cell.setCell("", lbl_name:"Ranking Gral",lbl_name2:"")
            return cell
        case 2:
            var cell = ViewCustomCell()
            cell.selectionStyle = .None
            cell.setCell("", lbl_name:"",lbl_name2:"Opciones")
            return cell
            
        case 3:
            var cell = ViewCustomCell()
            cell.selectionStyle = .None
            cell.setCell("", lbl_name:"Cerrar Sesión",lbl_name2:"")
            return cell
            
            
        default:
            var default_cell = ViewCustomCell()
            default_cell.selectionStyle = .None
            default_cell.setCell("circleProfile", lbl_name:"Parqueate",lbl_name2:"Algo")
            return default_cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 300.0
        }
        
        
        return 70.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Map") as UIViewController
        
        switch(selectedMenuItem){
        case 0:
            println("0")
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            
            // 2
            let deleteAction = UIAlertAction(title: "Tomar Foto", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                println("TakePicture")
                self.iniciarFoto()
                println("Verbose")
                
                
            })
            let saveAction = UIAlertAction(title: "Elegir del Carrete", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                println("ChooseOne")
                self.library();
                
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                println("Cancelled")
            })
            
            
            // 4
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(saveAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
        case 1:
            println("1")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Ranking") as UIViewController
                sideMenuController()?.setContentViewController(destViewController)

            
        case 2:
            println("2")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as
            UIViewController
            sideMenuController()?.setContentViewController(destViewController)

            
        case 3:
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("Main") as ViewController
            self.presentViewController(view, animated: true, completion: nil)
            break
            
        default:
            println("Default")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as UIViewController
            sideMenuController()?.setContentViewController(destViewController)

            break
            
        }
    }
    
    
    func imageWasSavedSuccessfully(image: UIImage,
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
    }
    
    
}