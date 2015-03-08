import UIKit

class ViewCustomCell: UITableViewCell {
    
    var view:UIView!
    var lbl:UILabel!
    var lbl_2:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(img_name:String, lbl_name:String,lbl_name2:String){
        
        self.backgroundColor = UIColor.clearColor()
        
        view = UIView()
        lbl = UILabel()
        lbl_2 = UILabel()
        
        self.lbl.text = lbl_name
        self.lbl_2.text = lbl_name2
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        self.lbl.frame = CGRect(x:45,y:15,width:150,height:30)
        self.lbl_2.frame = CGRect(x: 65, y: 35, width: 150, height: 50)
        self.view.frame = CGRect(x: 20, y: 5, width: 180, height: 2)
        
        self.contentView.addSubview(lbl)
        self.contentView.addSubview(lbl_2)
        self.contentView.addSubview(view)
    }
    
}