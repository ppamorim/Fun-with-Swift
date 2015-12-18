import AlamofireImage

class ImageViewCell : UITableViewCell {
  
  var didUpdateConstraints = false
  
  var url : String? = nil
  
  let someImage : UIImageView = {
    let someImage = UIImageView.newAutoLayoutView()
    someImage.backgroundColor = UIColor.blackColor()
    return someImage
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(someImage)
    self.setNeedsUpdateConstraints()
  }
  
  override func updateConstraintsIfNeeded() {
    if !didUpdateConstraints {
      someImage.autoPinEdgesToSuperviewEdges()
      didUpdateConstraints = true
    }
    super.updateConstraintsIfNeeded()
  }
  
  func update() {
    if url != nil {
      
      print("someImage.frame.size: \(someImage.frame.size)")
      
      let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
        size: someImage.frame.size,
        radius: 5.0)
      someImage.af_setImageWithURL(
        NSURL(string: url!)!,
        placeholderImage: nil,
        filter: filter,
        imageTransition: .None)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
}