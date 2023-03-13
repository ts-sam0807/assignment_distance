class Distance: CustomStringConvertible {
  
  private(set) var miles: Int       = 0
  private(set) var yards: Int       = 0
  private(set) var feet: Int        = 0
  private(set) var inches: Int      = 0
  private(set) var totalInches: Int = 0
  
  var description: String {
    var _returnString: String = "("
    if (miles > 0 || yards > 0 || feet > 0 || inches > 0) {
      if miles > 0 {
        _returnString += "\(miles)m "
      }
      if yards > 0 {
        _returnString += "\(yards)y "
      }
      if feet > 0 {
        _returnString += "\(feet)' "
      }
      if inches > 0 {
        _returnString += "\(inches)\""
      }
    }else{
      _returnString += "0\""
    }
    return _returnString + ")"
  }
  
  // Initialize
  init?() {
    self.miles        = 0
    self.yards        = 0
    self.feet         = 0
    self.inches       = 0
    self.totalInches  = 0
  }
  
  init?(inches: Int) {
    guard inches >= 0 else {
      return nil
    }
    self.totalInches = inches
    simplify()
  }
  
  init?(miles: Int, yards: Int, feet: Int, inches: Int) {
    guard miles >= 0, yards >= 0, feet >= 0, inches >= 0 else {
      return nil
    }
    
    self.totalInches = inches + feet * 12 + yards * 36 + miles * 63360
    simplify()
  }
  
  // Convert to different units
  private func simplify() {
    var remainingInches = totalInches
    
    self.miles = remainingInches / 63360
    remainingInches -= miles * 63360
    
    self.yards = remainingInches / 36
    remainingInches -= yards * 36
    
    self.feet = remainingInches / 12
    remainingInches -= feet * 12
    
    self.inches = remainingInches
  }
  
  // + - * operation
  static func +(lhs: Distance, rhs: Distance) -> Distance {
    let totalInches = lhs.totalInches + rhs.totalInches
    return Distance(inches: totalInches)!
  }
  
  static func -(lhs: Distance, rhs: Distance) -> Distance? {
    let totalInches = lhs.totalInches - rhs.totalInches
    if (totalInches > 0){
      return Distance(inches: totalInches)!
    }else{
      return nil
    }
  }
  
  static func *(lhs: Distance, rhs: Int) -> Distance {
    let totalInches = lhs.totalInches * rhs
    return Distance(inches: totalInches)!
  }
  
  static func +=(lhs: Distance, rhs: Int) {
    lhs.totalInches += rhs
    lhs.simplify()
  }
  
  // Compare operation
  static func < (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches < rhs.totalInches
  }
  
  static func > (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches > rhs.totalInches
  }
  
  static func <= (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches <= rhs.totalInches
  }
  
  static func >= (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches >= rhs.totalInches
  }
  
  static func == (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches == rhs.totalInches
  }
  
  static func != (lhs: Distance, rhs: Distance) -> Bool {
    return lhs.totalInches != rhs.totalInches
  }
  
  
}
