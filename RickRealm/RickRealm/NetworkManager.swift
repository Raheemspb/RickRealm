//
//  NetworkManager.swift
//  RickRealm
//
//  Created by Рахим Габибли on 04.07.2024.
//

import Foundation
import RealmSwift

struct ReturnedClass: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let gender: String
    let status: String
    let origin: Location


}

struct Location: Codable {
    let name: String
}

class NetworkManager {

    let realm = try! Realm()

    let urlString = "https://rickandmortyapi.com/api/character"

    func getCharacters(complition: @escaping ([Character]) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
                return
            }
            guard let data else {
                print("No data")
                return
            }

            do {
                let characters = try JSONDecoder().decode(ReturnedClass.self, from: data).results
                print("Good")

                DispatchQueue.main.async {
                for character in characters {
                        try! self.realm.write {
                            let rmRealm = RMRealmClass()
                            rmRealm.personIDRealm = String(character.id)
                            rmRealm.nameRealm = character.name
                            rmRealm.imageURLRealm = character.image
                            rmRealm.genderRealm = character.gender
                            rmRealm.speciesRealm = character.species
                            rmRealm.statusRealm = character.status
                            rmRealm.locationRealm = character.origin.name
                            self.realm.add(rmRealm, update: .modified)
                        }
                    }
                    complition(characters)
                }
            } catch {
                print("Error", error.localizedDescription)
            }
        }.resume()

    }

}
