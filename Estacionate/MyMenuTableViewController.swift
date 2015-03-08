import UIKit

class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var counter : Int = 0
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
            var cell = CustomMainCell()
            cell.selectionStyle = .None
            cell.setCell("yips.jpg", lbl_name:"Alejandro", lbl_last:"Zepeda",ranking:"Ranking: 57.4")
            return cell
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
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as UIViewController
            sideMenuController()?.setContentViewController(destViewController)

            
        case 1:
            println("1")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as UIViewController
                sideMenuController()?.setContentViewController(destViewController)

            
        case 2:
            println("2")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as
            UIViewController
            sideMenuController()?.setContentViewController(destViewController)

            
        case 3:
            dismissViewControllerAnimated(true, completion: nil)
            break
            
        default:
            println("Default")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("options") as UIViewController
            sideMenuController()?.setContentViewController(destViewController)

            break
            
        }
    }
    
    
}