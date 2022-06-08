//
//  ViewController.swift
//  Animals
//
//  Created by 강대민 on 2022/06/08.
//

import UIKit

struct Group {
    let title: String
    let animals: [String]
}

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let animals: [String: [String]] = [
    
        "A": ["Ant Eater"],
        "B": ["Bear", "Bird"],
        "C": ["Cat"],
        "D": ["Dog"],
        "E": ["Eagle"],
        "F": ["Fish", "Frog"],
        "G": ["Gorilla", "Gold Fish"],
        "H": ["Haaaaa"],
        "I": ["IIIIIIII"],
        "J": ["JJ", "JJJ"]
        
    ]
    
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var models = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUPdata()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUPdata() {
        //이렇게 데이터가 키 밸류 구조로 단순하게 되어있다면 이렇게하는것도 좋아보인다.
        for (key, value) in animals {
            models.append(Group(title: key, animals: value))
        }
        models = models.sorted(by: { $0.title < $1.title })
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect (
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height-view.safeAreaInsets.top
        )
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.section].animals[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return models.compactMap({$0.title})
        return Array(alphabet.uppercased()).compactMap({ "\($0)"})
        //이렇게 shuffled()를 사용하게되면 인덱스의 순서가 랜덤으로 바뀐다.
        //        return Array(alphabet.uppercased()).shuffled().compactMap({ "\($0)"})
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        //인덱스에 해당하는 셀이 없을떄 사용하면 좋다.
        guard let targetIndex = models.firstIndex(where: {$0.title == title}) else {
            return 0
        }
        return targetIndex
    }
}

