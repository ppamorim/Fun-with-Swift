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
    self.view.setNeedsUpdateConstraints()
  }

  override func updateViewConstraints() {
    if(!didUpdateViews) {
      tableView.autoPinEdgesToSuperviewEdges()
      tableView.delegate = self
      tableView.dataSource = self
      tableView.reloadData()
      didUpdateViews = true
    }
    super.updateViewConstraints()
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
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ImageViewCell", forIndexPath: indexPath) as! ImageViewCell
    
    let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
      size: cell.someImage.frame.size,
      radius: 5.0)
    
    cell.someImage.af_setImageWithURL(
      NSURL(string: (links[indexPath.row]))!,
      placeholderImage: nil,
      filter: filter,
      imageTransition: .None)
    
    return cell
  }
  
}