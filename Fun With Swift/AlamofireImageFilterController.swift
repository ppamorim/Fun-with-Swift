import UIKit
import AlamofireImage
import PureLayout

class AlamofireImageFilterController : UIViewController {
  
  var didUpdateViews = false
  
  let links : [String] = [
    "https://www.eff.org/files/https-everywhere-button.png",
    "https://www.eff.org/files/https-everywhere-button.png",
    "https://www.eff.org/files/https-everywhere-button.png"]
 
  let tableView : UITableView = {
    let tableView = UITableView.newAutoLayoutView()
    tableView.registerClass(ImageViewCell.self, forCellReuseIdentifier: "ImageViewCell")
    return tableView
  }()
  
  override func loadView() {
    super.loadView()
    self.view.addSubview(tableView)
    configDelegate()
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
  }

  override func updateViewConstraints() {
    if(!didUpdateViews) {
      tableView.autoPinEdgesToSuperviewEdges()
      didUpdateViews = true
    }
    super.updateViewConstraints()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  func configDelegate() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

extension AlamofireImageFilterController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
}

extension AlamofireImageFilterController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.links.count ?? 0
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let imageCell = cell as! ImageViewCell
    imageCell.url = links[indexPath.row]
    imageCell.update()
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier("ImageViewCell", forIndexPath: indexPath)
  }
  
}