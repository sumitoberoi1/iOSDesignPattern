/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Delegation
 - - - - - - - - - -
 ![Delegation Diagram](Delegation_Diagram.png)
 
 The delegation pattern allows an object to use a helper object to perform a task, instead of doing the task itself.
 
 This allows for code reuse through object composition, instead of inheritance.
 
 ## Code Example
 */
import UIKit
public class MenuViewController: UIViewController {
    @IBOutlet public var tableView:UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private let items = ["Item 1","Item 2","Item 3"]
    public weak var delegate:MenuViewControllerProtocol?
}
public protocol MenuViewControllerProtocol: class {
    func menuViewController(_ menuViewController:MenuViewController, didSelectItemAtIndex index:Int)
}
extension MenuViewController:UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
extension MenuViewController:UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuViewController(self, didSelectItemAtIndex: indexPath.row)
    }
}
