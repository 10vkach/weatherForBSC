import Foundation
import UIKit

class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var stackViewTempretureUnits: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    var model: WeatherList?
    
    private var buttonsTempratureUnits: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseID)
        setStackViewTempratureUnits()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

//MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.places.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID) as? CityTableViewCell,
            let modelSafe = model else {
            print("Ошибка при переиспользовании ячейки \(indexPath)")
            return UITableViewCell()            
        }
        cell.setUI(with: modelSafe.places[indexPath.row], tempretureUnits: modelSafe.tempratureUnits)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {        
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { _, _, complete in
                self.model?.places.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                complete(true)
            })
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
//MARK: Actions
    @IBAction func addCity(_ sender: Any) {
        guard let addCityViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "AddCityViewControllerID")
            as? AddCityViewController else {
                print("Ошибка при создании ConfigViewController")
                return
        }
        addCityViewController.model = model
        present(addCityViewController, animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        buttonsTempratureUnits.forEach({ $0.setTitleColor(.systemGray3, for: .normal) })
        sender.setTitleColor(.systemGray, for: .normal)
        let selectedUnits = TempratureUnits.allCases[sender.tag]
        model?.tempratureUnits = selectedUnits
        tableView.reloadData()
    }
    
//MARK: Private
    private func setStackViewTempratureUnits() {
        var allUnits = TempratureUnits.allCases
        let firstUnits = allUnits.removeFirst()
        stackViewTempretureUnits.addArrangedSubview(createButtonTempratureUnits(forUnits: firstUnits, withTag: 0))
        for i in 0..<allUnits.count {
            stackViewTempretureUnits.addArrangedSubview(createLabelSplitter())
            stackViewTempretureUnits.addArrangedSubview(createButtonTempratureUnits(forUnits: allUnits[i], withTag: i + 1))
        }
    }
    
    private func createButtonTempratureUnits(forUnits units: TempratureUnits, withTag tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("\(units.rawValue)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        if model?.tempratureUnits == units {
            button.setTitleColor(.systemGray, for: .normal)
        } else {
            button.setTitleColor(.systemGray3, for: .normal)
        }
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = tag
        buttonsTempratureUnits.append(button)
        return button
    }
    
    private func createLabelSplitter() -> UILabel {
        let label = UILabel()
        label.text = "/"
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = .systemGray
        return label
    }
}
