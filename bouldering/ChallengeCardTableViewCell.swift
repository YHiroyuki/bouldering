//
//  ChallengeCardTableViewCell.swift
//  bouldering
//
//  Created by 山脇寛之 on 2019/03/16.
//  Copyright © 2019 Hiroyuki. All rights reserved.
//

import UIKit

class ChallengeCardTableViewCell: UITableViewCell {

    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var challengeDate: UILabel!
    @IBOutlet weak var completeDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
