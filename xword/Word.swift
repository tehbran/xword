//
//  Word.swift
//  xword
//
//  Created by Brandon Nguyen on 4/17/19.
//  Copyright © 2019 Brandon Nguyen. All rights reserved.
//

struct Word: Hashable{
    var word: String!
    var clue: String!
    var number: String!
    var orientation: String!

    func hash(into hasher: inout Hasher){
        hasher.combine(word)
    }
}
