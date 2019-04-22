//
//  crosswordScreenViewController.swift
//  xword
//
//  Created by Brandon Nguyen on 4/17/19.
//  Copyright © 2019 Brandon Nguyen. All rights reserved.
//

import UIKit


class crosswordScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, XMLParserDelegate {
    
    var collectionView: UICollectionView!
    var clueBox : UIView!
    var gridSize: CGFloat = 13
    
    var words = [Word: [crosswordCell]]()
    var grid = [crosswordCell: Character]()
    
    var parsedGrid: [Character] = []
    var rowString: String = String()
    var elementName: String = String()
    
    var word: String = String()
    var clue: String = String()
    var number: String = String()
    var orientation: String = String()
    var row: Int!
    var col: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "nature", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate = self
                parser.parse()
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(crosswordCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        clueBox = UIView(frame: CGRect(x: 0, y: collectionView.frame.height + 20, width: view.frame.width, height:200))
        clueBox.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(clueBox, belowSubview: collectionView)
        clueBox.backgroundColor = UIColor.black
        
        
        view.addConstraints([
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 30),
            NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width)])
        
        view.addConstraints([
            NSLayoutConstraint(item: clueBox, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: clueBox, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: clueBox, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width)])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(pow(Double(gridSize), 2))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! crosswordCell
        grid[cell] = parsedGrid[indexPath.row]
        if(parsedGrid[indexPath.row] == "."){
            cell.blankCell()
        }
        for (key, var value) in words{
            let range = (key.row - 1) * 13 + key.col - 1
            if (range ... range + key.word.count ~= indexPath.row){
                if(value.isEmpty){
                    cell.numLabel.text = key.number
                }
                value.append(cell)
                words[key] = value
            }
        }
        print(words)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width / gridSize - 1
        return CGSize(width: size, height: size)
    }
    
    func parser(_ parser:XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Row" {
            rowString = String()
        } else if elementName == "Clue" {
            number = String()
            word = String()
            orientation = String()
            clue = String()
            if let num = attributeDict["Num"]{
                number = num
            }
            if let ans = attributeDict["ANS"]{
                word = ans
            }
            if let dir = attributeDict["Dir"]{
                orientation = dir
            }
            if let Row = attributeDict["Row"]{
                row = Int(Row)
            }
            if let Col = attributeDict["Col"]{
                col = Int(Col)
            }
            
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "Row" {
            let characters = Array(rowString)
            parsedGrid.append(contentsOf: characters)
        } else if elementName == "Clue"{
            words[Word(word: word, clue: clue, number: number, orientation: orientation, row: row, col: col)] = []
        }
    }
    
    func parser(_ parser:XMLParser, foundCharacters string: String){
        if (!string.isEmpty){
            if self.elementName == "Row"{
                rowString = string
            } else if self.elementName == "Clue"{
                clue = string
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}

