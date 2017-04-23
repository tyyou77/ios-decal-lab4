//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    var table: TableViewCell?
    var pokemon: Pokemon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.delegate = self
        secondTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        table = tableView.dequeueReusableCell(withIdentifier: "identity2", for: indexPath) as? TableViewCell
        pokemon = pokemonArray?[indexPath.row]
        table?.name.text = pokemon!.name
        table?.number.text = String(describing: pokemon!.number!)
        table?.keyStats.text = "\(pokemon!.attack!)/\(pokemon!.defense!)/\(pokemon!.health!)"
        if let image = cachedImages[indexPath.row] {
            table?.pokemonImage.image = image
        } else {
            let url = URL(string: (pokemon?.imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            self.table?.pokemonImage.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        return table!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "second", sender: selectedIndexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "second" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    dest.pokemon = pokemonArray?[(selectedIndexPath?.item)!]
                    if let image = cachedImages[(selectedIndexPath?.item)!] {
                        table?.pokemonImage.image = image
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var secondTableView: UITableView!
    
}
