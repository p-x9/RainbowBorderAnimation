//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    let shapeLayer = CAShapeLayer()
    let label = UILabel()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        label.sizeToFit()
        
        view.addSubview(label)
        
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: label.frame.width+8, height: label.frame.height+8))

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.0
        shapeLayer.lineWidth = 8.0
        label.layer.addSublayer(shapeLayer)
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = rainbow()
        gradientLayer.frame = CGRect(x: -4, y: -4, width: label.frame.width+8, height: label.frame.height+8)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.mask = shapeLayer
        label.layer.addSublayer(gradientLayer)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(anim))
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func anim() {
        let animation1 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation1.fromValue         = 0.0
        animation1.toValue           = 1.0
        animation1.duration          = 1.0
        
        animation1.beginTime = 0
        
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = .forwards
        
        
        let animation2 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        animation2.fromValue         = 0.0
        animation2.toValue           = 1.0
        animation2.duration          = 1.0
        animation2.beginTime = 1/*+CACurrentMediaTime()*/
        
        
        let group = CAAnimationGroup()
        group.duration = 2.0
        group.repeatCount = .infinity
        group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        group.animations = [animation1,animation2]

        self.shapeLayer.add(group, forKey: "group-animation")
    }
}

func rainbow()->[CGColor]{
    var colors:[CGColor] = []
    let increment:CGFloat = 0.02
    for hue:CGFloat in stride(from: 0.0, to: 1.0, by: increment) {
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        colors.append(color.cgColor)
    }
    [CGFloat](stride(from: 0.0, to: 1.0, by: increment)).map{hue in UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor}
    return colors
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
