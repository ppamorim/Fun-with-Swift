// ###### NOT WORKING CODE WITH PURE LAYOUT ######

import UIKit
import MapKit
import PureLayout
import kingpin

private let NumberOfAnnotations = 1000

class KingPinBugController : UIViewController {
  
  var didUpdateViews = false;
  
  private var clusteringController : KPClusteringController!
  
  var mapView : MKMapView = {
    let mapView = MKMapView.newAutoLayoutView()
    mapView.mapType = .Standard
    return mapView
    }()
  
  override func loadView() {
    super.loadView()
    self.view.addSubview(mapView)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configClustering()
  }
  
  override func updateViewConstraints() {
    if(!didUpdateViews) {
      mapView.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view)
      mapView.autoMatchDimension(.Height, toDimension: .Height, ofView: self.view)
      didUpdateViews = true
    }
    super.updateViewConstraints()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    clusteringController.refresh(true)
  }
  
  func configClustering() {
    let algorithm : KPGridClusteringAlgorithm = KPGridClusteringAlgorithm()
    algorithm.annotationSize = CGSizeMake(25, 50)
    algorithm.clusteringStrategy = KPGridClusteringAlgorithmStrategy.TwoPhase;
    clusteringController = KPClusteringController(mapView: self.mapView, clusteringAlgorithm: algorithm)
    clusteringController.delegate = self
    clusteringController.setAnnotations(annotations())
    mapView.centerCoordinate = self.nycCoord()
  }
  
  func annotations() -> [TestAnnotation] {
    var annotations: [TestAnnotation] = []
    
    let nycCoord: CLLocationCoordinate2D = self.nycCoord()
    
    for var i = 0; i < NumberOfAnnotations; i++ {
      let latAdj: Double = ((Double(random()) % 1000) / 1000.0)
      let lngAdj: Double = ((Double(random()) % 1000) / 1000.0)
      
      let coordinate1 : CLLocationCoordinate2D = CLLocationCoordinate2DMake(nycCoord.latitude + latAdj, nycCoord.longitude + lngAdj)
      
      let a1: TestAnnotation = TestAnnotation(coordinate: coordinate1)
      
      annotations.append(a1)
    }
    
    return annotations
  }
  
  func nycCoord() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(40.77, -73.98)
  }
  
}

extension KingPinBugController : MKMapViewDelegate {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      //             return nil so map view draws "blue dot" for standard user location
      return nil
    }
    
    let pin = "pin"
    
    var view = mapView.dequeueReusableAnnotationViewWithIdentifier(pin) as? MKPinAnnotationView
    
    if view == nil {
      view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
      view!.canShowCallout = true
      view!.animatesDrop = false
    } else {
      view!.annotation = annotation
    }
    
    return view
  }
  
  func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    clusteringController.refresh(true)
  }
  
  func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    if view.annotation is KPAnnotation {
      let cluster = view.annotation as! KPAnnotation
      
      if cluster.annotations.count > 1 {
        let region = MKCoordinateRegionMakeWithDistance(
          cluster.coordinate,
          cluster.radius * 2.5,
          cluster.radius * 2.5)
        
        mapView.setRegion(region, animated: true)
      }
    }
  }
}

// MARK: <CLControllerDelegate>

extension KingPinBugController : KPClusteringControllerDelegate {
  func clusteringControllerShouldClusterAnnotations(clusteringController: KPClusteringController!) -> Bool {
    return true
  }
}