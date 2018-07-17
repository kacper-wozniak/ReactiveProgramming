//
//  SearchViewController.swift
//  ReactiveProgramming
//
//  Created by Kacper Woźniak on 09/01/2017.
//  Copyright © 2017 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        searchBar.rx.text.orEmpty.asDriver()
            .filter { $0.characters.count > 3 }
            .distinctUntilChanged()
            .throttle(1)
            .map { URL(string: "https://api.github.com/search/repositories?q=" + $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)! }
            .flatMapLatest {
                URLSession.shared.rx.json(url: $0).asDriver(onErrorJustReturn: [:])
            }
            .map { json -> [[String : AnyObject]] in
                let dict = json as? [String : AnyObject]
                return dict?["items"] as? [[String : AnyObject]] ?? []
            }
            .map { array -> [Repository] in
                return array.flatMap { Repository(json: $0) }
            }
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { (_, repo, cell) in
                cell.textLabel?.text = repo.name
                cell.detailTextLabel?.text = repo.url
            }
            .addDisposableTo(disposeBag)
    }

}

struct Repository {

    let name: String
    let url: String

    init?(json: [String : Any]) {
        guard let name = json["name"] as? String,
              let url = json["url"] as? String
        else { return nil }
        self.name = name
        self.url = url
    }

}
