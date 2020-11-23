import UIKit

class GDTableView : UITableView {
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        if frame == .zero {
            translatesAutoresizingMaskIntoConstraints = false
        }
        backgroundColor = .clear
        separatorStyle = .none
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
