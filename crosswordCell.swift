//
//  crosswordCell.swift
//  xword
//
//  Created by Brandon Nguyen on 4/15/19.
//  Copyright © 2019 Brandon Nguyen. All rights reserved.
//

import UIKit

class crosswordCell: UICollectionViewCell, UITextFieldDelegate {
    var numLabel : UILabel!
    var entry : UITextField!

    required init?(coder aDecder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
       
        self.numLabel = UILabel()
        
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(numLabel)
        numLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 0).isActive = true
        numLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        numLabel.text = ""
        numLabel.font = numLabel.font.withSize(9)
        
        self.entry = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        entry.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(entry)
        
        entry.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 0).isActive = true
        entry.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        entry.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        entry.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        
        
        entry.backgroundColor = UIColor.clear
        entry.textAlignment = .center
        entry.borderStyle = .none
        entry.delegate = self
        entry.font = entry.font!.withSize(20)
        entry.tintColor = .clear
    }
    
    func blankCell(){
        entry.text = "."
        backgroundColor = UIColor.black
        entry.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if string == " " {
            return false
        } else {
            return newString.length <= maxLength
        }

    }
    
}
