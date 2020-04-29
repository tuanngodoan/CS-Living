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
        self.timeLabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(feeDetail: FeeDetail?) {
        guard let detail = feeDetail else {
            return
        }
        self.timeLabel.text = "zzzz"
        self.serviceLabel.text = "\(detail.chargeCode ?? "")"
        self.loanPrevLabel.text = "\(detail.closingDebit ?? 0)"
        self.incurredDebtLabel.text = "\(detail.openingDebit ?? 0)"
        self.paidLabel.text = "\(detail.paidAmount ?? 0)"
        self.endingDebtLabel.text = "\(detail.accruedExpense ?? 0)"
    }
    
}
