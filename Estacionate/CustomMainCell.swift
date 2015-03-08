
import UIKit

class CustomMainCell: UITableViewCell {
    
    var iv_user: UIImageView!
    var lbl_name: UILabel!
    var lbl_ranking:UILabel!
    var lbl_lastName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(main_img:String, lbl_name:String,lbl_last:String, ranking:String){
        
        self.lbl_lastName = UILabel()
        self.iv_user = UIImageView()
        self.lbl_name = UILabel()
        self.lbl_ranking = UILabel()
        
        self.backgroundColor = UIColor.clearColor()
        
        self.iv_user.frame = CGRect(x: 45,y: 20,width: 130,height: 130)
        self.lbl_name.frame = CGRect(x: 60,y: 140,width: 180,height: 120)
        self.lbl_lastName.frame = CGRect(x: 67, y: 170, width: 180, height: 120)
        self.lbl_ranking.frame = CGRect(x: 55, y: 250, width: 180, height: 45)
        
        self.iv_user.image = UIImage(named: main_img)
        self.lbl_name.text = lbl_name
        self.lbl_lastName.text = lbl_last
        self.lbl_ranking.text = ranking
        
        self.lbl_name.font = UIFont(name: self.lbl_name.font.fontName, size: 25)
        self.lbl_lastName.font = UIFont(name: self.lbl_name.font.fontName, size: 25)
        
        contentView.addSubview(self.lbl_lastName)
        contentView.addSubview(self.iv_user)
        contentView.addSubview(self.lbl_name)
        contentView.addSubview(self.lbl_ranking)
    }
    
    func mascotas(){
        println("Mascotas")
    }
    
}