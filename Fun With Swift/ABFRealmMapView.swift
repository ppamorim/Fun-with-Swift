//
//  ABFRealmMapView.swift
//  Fun With Swift
//
//  Created by Pedro Paulo Amorim on 14/10/15.
//  Copyright © 2015 Pedro Paulo Amorim. All rights reserved.
//

import PureLayout
import RealmMapView
import RealmSwift
import RealmSwiftSFRestaurantData

class ABFRealmMapView : UIViewController {
  
  var didUpdateViews = false
  
  var realmMapView : RealmMapView = {
    let realmMapView = RealmMapView.newAutoLayoutView()
    realmMapView.mapType = .Standard
    realmMapView.entityName = "ABFRestaurantObject"
    realmMapView.latitudeKeyPath = "latitude"
    realmMapView.longitudeKeyPath = "longitude"
    realmMapView.titleKeyPath = "name"
    realmMapView.subtitleKeyPath = "phoneNumber"
    return realmMapView
    }()
  
  override func loadView() {
    super.loadView()
    self.view.addSubview(realmMapView)
    self.view.setNeedsUpdateConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.realmMapView.delegate = self
    var config = Realm.Configuration.defaultConfiguration
    config.path = ABFRestaurantScoresPath()
    self.realmMapView.realmConfiguration = config
    self.realmMapView.fetchedResultsController.clusterTitleFormatString = "$OBJECTSCOUNT restaurants in this area"
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.realmMapView.refreshMapView()
  }
  
  override func updateViewConstraints() {
    if(!didUpdateViews) {
      realmMapView.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view)
      realmMapView.autoMatchDimension(.Height, toDimension: .Height, ofView: self.view)
      realmMapView.autoCenterInSuperview()
      didUpdateViews = true
    }
    super.updateViewConstraints()
  }
  
}

extension ABFRealmMapView : MKMapViewDelegate {
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    print(view)
    return nil
  }
  
  func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    print("ola!")
  }
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
    print(view)
  }
}
