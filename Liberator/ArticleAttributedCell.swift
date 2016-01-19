import UIKit

class ArticleAttributedCell: UITableViewCell {
    
    
    @IBOutlet var attr_string: UILabel!
    @IBOutlet var feature_image: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
