//
//  ViewController.swift
//  RickRealm
//
//  Created by Рахим Габибли on 04.07.2024.
//

import UIKit
import RealmSwift
import SnapKit

class ViewController: UIViewController {

    var tableView: UITableView!
    let image = UIImageView()
    let networkManager = NetworkManager()

    var characters2: Results<RMRealmClass>{
        get{return self.networkManager.realm.objects(RMRealmClass.self)}
    }

    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.rowHeight = 150

        networkManager.getCharacters { [weak self] characters in
            self?.characters = characters

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.dataSource = self

        tableView.snp.makeConstraints { make in
            make.top.bottom.height.width.equalToSuperview()
        }

    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(characters2.count)
        return characters2.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }


        let character = characters2[indexPath.row]

        guard let url = URL(string: character.imageURLRealm) else { return cell }
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
                cell.configure(
                    imageData: imageData,
                    name: character.nameRealm,
                    species: character.speciesRealm,
                    gender: character.genderRealm,
                    origin: character.locationRealm,
                    status: character.statusRealm
                )
            }
        }
        return cell
    }


}

