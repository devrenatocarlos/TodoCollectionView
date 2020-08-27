//
//  ListViewViewController.swift
//  HomeWorkToDo
//
//  Created by aluno on 10/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fabButton: CircleButton!
    var isLandiscape : Bool = false{
        didSet{
            animatedViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCollectionView()
        configureNavigationBar()
        fabButton.isHidden = traitCollection.horizontalSizeClass == .regular
        isLandiscape = traitCollection.horizontalSizeClass == .regular
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    // tela a mudar de orientacao
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // regular = landscape ||    compact = portrait     ISSO USANDO HORIZONTALSIZECLASS
        isLandiscape = newCollection.horizontalSizeClass == .regular
        fabButton.isHidden = isLandiscape
        let isExistItem = TodoDataSource.shared.todosCollection.collectionDictionary.count > 0
        configureCollectionView(willTransition: isExistItem)
        //collectionView.reloadData()
    }

}
// MARK: configuration methods extension
extension ListViewController {
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListTableViewCellID")
    }
    
    private func configureNavigationBar(){
            navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func animatedViews(){
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = self.isLandiscape
            self.collectionView.isHidden = !self.isLandiscape
        }
    }
    
    private func configureCollectionView(willTransition: Bool = false){
        
        var width = UIScreen.main.bounds.size.width
        var height = UIScreen.main.bounds.size.height
       
        if willTransition {
            width = UIScreen.main.bounds.size.height
            height = UIScreen.main.bounds.size.width
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ((width - 128) / 3) , height: height * 0.7)
        collectionView.collectionViewLayout = layout
        
        if(TodoDataSource.shared.todosCollection.collectionDictionary.count > 0){
            collectionView.delegate = self
            collectionView.dataSource = self
            let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCellID")
        }
        
    }
}
// MARK: Action methods extension
extension ListViewController {
   
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Add", bundle: nil).instantiateInitialViewController() else {return}
        navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoDataSource.shared.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID") as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: TodoDataSource.shared.todos[indexPath.row])
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return TodoDataSource.shared.todosCollection.collectionDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCellID", for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10
        
        if TodoDataSource.shared.todosCollection.collectionDictionary.count > indexPath.row {
            cell.configure(model: TodoDataSource.shared.todosCollection,index: indexPath.row, cell: cell)
        }
        return cell
    }
}
