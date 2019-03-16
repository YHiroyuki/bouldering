//
//  ChallengeCard.swift
//  bouldering
//
//  Created by 山脇寛之 on 2019/03/16.
//  Copyright © 2019 Hiroyuki. All rights reserved.
//

import UIKit

enum CardStatus: String {
    case UnChallenged = "unchallenged"
    case Challenging = "challenging"
    case Complete = "complete"
}

class ChallengeCard: NSObject, NSCoding {

    var difficulty: String
    var detail: String
    var challengeDate: String
    var completeDate: String
    var status: CardStatus
    
    init(difficulty: String, detail: String, challengeDate: String, completeDate: String, status: CardStatus) {
        self.difficulty = difficulty
        self.detail = detail
        self.challengeDate = challengeDate
        self.completeDate = completeDate
        self.status = status
    }
    
    convenience init(difficulty: String, detail: String, challengeDate: String, completeDate: String) {
        self.init(difficulty: difficulty, detail: detail, challengeDate: challengeDate, completeDate: completeDate, status: .UnChallenged)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let difficulty = aDecoder.decodeObject(forKey: "difficulty") as! String
        let detail = aDecoder.decodeObject(forKey: "detail") as! String
        let challengeDate = aDecoder.decodeObject(forKey: "challengeDate") as! String
        let completeDate = aDecoder.decodeObject(forKey: "completeDate") as! String
        let status = CardStatus(rawValue: aDecoder.decodeObject(forKey: "status") as! String) ?? .UnChallenged
        
        self.init(difficulty: difficulty, detail: detail, challengeDate: challengeDate, completeDate: completeDate, status: status)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(difficulty, forKey: "difficulty")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(challengeDate, forKey: "challengeDate")
        aCoder.encode(completeDate, forKey: "completeDate")
        aCoder.encode(status.rawValue, forKey: "status")
    }
    
    func changeStatus(newStatus: CardStatus) {
        self.status = newStatus
    }
    
    func setComplateDate() {
        self.completeDate = self.getDate()
    }
    
    func setChalengeDate() {
        self.challengeDate = self.getDate()
    }
    
    private func getDate() -> String{
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return formatter.string(from: now as Date)
    }
}
