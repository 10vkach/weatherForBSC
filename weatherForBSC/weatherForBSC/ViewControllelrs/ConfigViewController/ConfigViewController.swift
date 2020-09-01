import Foundation
import UIKit

class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonUnitsFirst: UIButton!
    @IBOutlet weak var buttonUnitsSecond: UIButton!
    
    var model: WeatherList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseID)
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
    
    @IBAction func firstUnitsSelected(_ sender: Any) {
        buttonUnitsFirst.setTitleColor(.gray, for: .normal)
        buttonUnitsSecond.setTitleColor(.systemGray3, for: .normal)
        model?.tempratureUnits = .celsius
        tableView.reloadData()
    }
    
    @IBAction func secondUnitsSelected(_ sender: Any) {
        buttonUnitsFirst.setTitleColor(.systemGray3, for: .normal)
        buttonUnitsSecond.setTitleColor(.gray, for: .normal)
        model?.tempratureUnits = .farenheit
        tableView.reloadData()
    }
}
