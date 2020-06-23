//
//  Petition.swift
//  hws-07-WhitehousePetitions
//
//  Created by Philip Hayes on 6/22/20.
//  Copyright © 2020 PhilipHayes. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
