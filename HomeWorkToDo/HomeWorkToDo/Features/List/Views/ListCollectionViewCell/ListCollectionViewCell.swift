//
//  ListCollectionViewCell.swift
//  HomeWorkToDo
//
//  Created by aluno on 21/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstTodoLabel: UILabel!
    @IBOutlet weak var secondTodoLabel: UILabel!
    @IBOutlet weak var thirdTodoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
} // end class

// MARK: Configure Labels
extension ListCollectionViewCell {
    
    func configure(model: CollectionModel, index: Int, cell: UICollectionViewCell){
        //pegando as chaves do dicionario e transformando-as em array para poder manipular usando indice
        let typeKeys = [String](model.collectionDictionary.keys)
        
        //setando o tipo da celula com o tipo escolhido pelo usuário
        typeLabel.text = typeKeys[index]
        
        //setando background de cada celula de acordo com o tipo de tarefa escolhida pelo usuario
        switch(typeKeys[index]){
        case "onPriority":
            cell.contentView.backgroundColor = UIColor(named: "on_priority_color")
            setTodoLabels(type: "onPriority")
        case "daily":  cell.contentView.backgroundColor = UIColor(named: "daily_color")
        setTodoLabels(type: "daily")
        case "home":  cell.contentView.backgroundColor = UIColor(named: "home_color")
        setTodoLabels(type: "home")
        default:
            break
        }
    }
    
    func setTodoLabels(type: String){
        switch(type){
        case "onPriority":
            let priority = TodoDataSource.shared.priorityArray
            if priority.count > 3 {
                let complement = priority.count-3
                switch (priority.count-complement) {
                case 1: firstTodoLabel.text = priority[0+complement]
                    
                case 2: firstTodoLabel.text = priority[0+complement]
                secondTodoLabel.text = priority[1+complement]
                    
                case 3: firstTodoLabel.text = priority[0+complement]
                secondTodoLabel.text = priority[1+complement]
                thirdTodoLabel.text = priority[2+complement]
                default:
                    break
                }
            }else{
                switch (priority.count) {
                case 1: firstTodoLabel.text = priority[0]
                    
                case 2: firstTodoLabel.text = priority[0]
                secondTodoLabel.text = priority[1]
                    
                case 3: firstTodoLabel.text = priority[0]
                secondTodoLabel.text = priority[1]
                thirdTodoLabel.text = priority[2]
                default:
                    break
                }
            }
        case "daily":
            let daily = TodoDataSource.shared.dailyArray
            if daily.count > 3 {
                let complement = daily.count-3
                switch (daily.count-complement) {
                case 1: firstTodoLabel.text = daily[0+complement]
                    
                case 2: firstTodoLabel.text = daily[0+complement]
                secondTodoLabel.text = daily[1+complement]
                    
                case 3: firstTodoLabel.text = daily[0+complement]
                secondTodoLabel.text = daily[1+complement]
                thirdTodoLabel.text = daily[2+complement]
                default:
                    break
                }
            }else{
                switch (daily.count) {
                case 1: firstTodoLabel.text = daily[0]
                    
                case 2: firstTodoLabel.text = daily[0]
                secondTodoLabel.text = daily[1]
                    
                case 3: firstTodoLabel.text = daily[0]
                secondTodoLabel.text = daily[1]
                thirdTodoLabel.text = daily[2]
                default:
                    break
                }
            }
        case "home":
            let home = TodoDataSource.shared.homeArray
            if home.count > 3 {
                let complement = home.count-3
                switch (home.count-complement) {
                case 1: firstTodoLabel.text = home[0+complement]
                    
                case 2: firstTodoLabel.text = home[0+complement]
                secondTodoLabel.text = home[1+complement]
                    
                case 3: firstTodoLabel.text = home[0+complement]
                secondTodoLabel.text = home[1+complement]
                thirdTodoLabel.text = home[2+complement]
                default:
                    break
                }
            }else{
                switch (home.count) {
                case 1: firstTodoLabel.text = home[0]
                    
                case 2: firstTodoLabel.text = home[0]
                secondTodoLabel.text = home[1]
                    
                case 3: firstTodoLabel.text = home[0]
                secondTodoLabel.text = home[1]
                thirdTodoLabel.text = home[2]
                default:
                    break
                }
            }
        default:
            break
        }
        
    }
}
