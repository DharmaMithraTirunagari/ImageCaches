//
//  ViewController.swift
//  ImageCatches
//
//  Created by Srikanth Kyatham on 12/9/24.
//

import UIKit

class ImageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView =  UITableView()
    private let viewModel = ImageListViewModel(networkManager: NetworkManager.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTableView()
        fetchImages()
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func fetchImages() {
            viewModel.fetchImages { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.tableView.reloadData()
                    } else {
                        print("Failed to load images.")
                    }
                }
            }
        }


}

extension ImageListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
        cell.configure(with: viewModel.images[indexPath.row])
        return cell
    }
}

