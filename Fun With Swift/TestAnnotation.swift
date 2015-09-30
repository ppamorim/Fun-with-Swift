import MapKit.MKAnnotation

class TestAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
}