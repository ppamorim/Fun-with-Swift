import AlamofireImage

class ImageViewCell : UITableViewCell {
  
  var didUpdateConstraints = false
  
  let someImage : UIImageView = {
    let someImage = UIImageView.newAutoLayoutView()
    someImage.backgroundColor = UIColor.blackColor()
    return someImage
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(someImage)
    self.updateConstraintsIfNeeded()
  }
  
  override func updateConstraints() {
    if !didUpdateConstraints {
      someImage.autoPinEdgesToSuperviewEdges()
      didUpdateConstraints = true
    }
    super.updateConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
}