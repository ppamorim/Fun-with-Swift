import UIKit
import AlamofireImage
import PureLayout

class AlamofireImageFilterController : UIViewController {
  
  var didUpdateViews = false;
  
  let image : UIImageView = {
    let image = UIImageView.newAutoLayoutView()
    return image
    }()
  
  override func loadView() {
    super.loadView()
    self.view.addSubview(image)
    self.view.setNeedsUpdateConstraints()
  }
  
  /*
  * Load the image after 3 seconds, just a delay.
  */
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let delay = 3 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
      let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
        size: self.image.frame.size,
        radius: 5.0
      )
      
      self.image.af_setImageWithURL(
        NSURL(string: "https://i.imgur.com/S4hTFRz.jpg?1")!,
        placeholderImage: nil,
        filter: filter,
        imageTransition: .None)
    }
    
  }

  override func updateViewConstraints() {
    if(!didUpdateViews) {
      image.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 16,left: 16,bottom: 16,right: 16))
      didUpdateViews = true
    }
    print("updateViewConstraints")
    super.updateViewConstraints()
  }
  
}