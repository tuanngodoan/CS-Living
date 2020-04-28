//
//  FeeTableViewCell.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/27/20.
//

import UIKit

class FeeTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var loanPrevLabel: UILabel!
    @IBOutlet weak var incurredDebtLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var endingDebtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(fee: FeeModel) {
        self.timeLabel.text = String(describing: fee.closingDebit)
        self.serviceLabel.text = String(describing: fee.closingDebit)
        self.loanPrevLabel.text = String(describing: fee.closingDebit)
        self.incurredDebtLabel.text = String(describing: fee.closingDebit)
        self.paidLabel.text = String(describing: fee.closingDebit)
        self.endingDebtLabel.text = String(describing: fee.closingDebit)
    }
    
}
