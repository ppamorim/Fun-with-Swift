import UIKit
import PureLayout

class ViewController : UIViewController {
    
    var didUpdateViews = false;
    
    var buttonOne: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = UIColor.blueColor()
        return view
        }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.redColor()
        view.addSubview(buttonOne)
        view.setNeedsUpdateConstraints() // bootstrap Auto Layout
    }
    
    override func updateViewConstraints() {
        if(!didUpdateViews) {
            updateButtonOne()
            didUpdateViews = true
        }
        super.updateViewConstraints()
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.redColor()
//        addButtonOne()
//        
//        // Do any additional setup after loading the view, typically from a nib.
////        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
////        appDelegate.startSecondViewController()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateButtonOne() -> Void {
//        buttonOne.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.view)
        buttonOne.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view)
        buttonOne.autoSetDimension(.Height, toSize: 40.0)
    }

}

