//import SwiftUI
//
//struct SquigglyBob: View {
//    var body: some View {
//        VStack {
//            var view = UIView()
//            view.frame = CGRect(x: 0, y: 0, width: 150.9, height: 262.62)
//            var shadows = UIView()
//            shadows.frame = view.frame
//            shadows.clipsToBounds = false
//            view.addSubview(shadows)
//
//            let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
//            let layer0 = CALayer()
//            layer0.shadowPath = shadowPath0.cgPath
//            layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            layer0.shadowOpacity = 1
//            layer0.shadowRadius = 4
//            layer0.shadowOffset = CGSize(width: 0, height: 4)
//            layer0.bounds = shadows.bounds
//            layer0.position = shadows.center
//            shadows.layer.addSublayer(layer0)
//
//            var shapes = UIView()
//            shapes.frame = view.frame
//            shapes.clipsToBounds = true
//            view.addSubview(shapes)
//
//            let layer1 = CAGradientLayer()
//            layer1.colors = [
//              UIColor(red: 1, green: 0.042, blue: 0, alpha: 0).cgColor,
//              UIColor(red: 0.971, green: 0.546, blue: 0.322, alpha: 1).cgColor
//            ]
//            layer1.locations = [0, 1]
//            layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
//            layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
//            layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.01, b: 0.95, c: -1.5, d: 0.01, tx: 0.94, ty: -0.07))
//            layer1.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//            layer1.position = shapes.center
//            shapes.layer.addSublayer(layer1)
//
//            let layer2 = CAGradientLayer()
//            layer2.colors = [
//              UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//              UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//              UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//              UIColor(red: 0.725, green: 0, blue: 1, alpha: 0).cgColor,
//              UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor
//            ]
//            layer2.locations = [1, 1, 1, 1, 1]
//            layer2.startPoint = CGPoint(x: 0.25, y: 0.5)
//            layer2.endPoint = CGPoint(x: 0.75, y: 0.5)
//            layer2.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.01, b: 1, c: -0.86, d: 0, tx: 0.93, ty: 0))
//            layer2.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//            layer2.position = shapes.center
//            shapes.layer.addSublayer(layer2)
//
//            let layer3 = CAGradientLayer()
//            layer3.colors = [
//              UIColor(red: 0.254, green: 0.74, blue: 1, alpha: 0).cgColor,
//              UIColor(red: 0.254, green: 0.74, blue: 1, alpha: 1).cgColor,
//              UIColor(red: 0.254, green: 1, blue: 0.951, alpha: 1).cgColor
//            ]
//            layer3.locations = [0, 1, 1]
//            layer3.startPoint = CGPoint(x: 0.25, y: 0.5)
//            layer3.endPoint = CGPoint(x: 0.75, y: 0.5)
//            layer3.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
//            layer3.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//            layer3.position = shapes.center
//            shapes.layer.addSublayer(layer3)
//
//
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            // Use the SquigglyBob view directly in SwiftUI
//            SquigglyBob()
//                .frame(width: 150.9, height: 262.62)
//        }
//    }
//}

import SwiftUI

struct SquigglyBobWrapper: View {
    var body: some View {
        SquigglyBobView()
    }
}

struct SquigglyBobView: View {
    var body: some View {
        GeometryReader { geometry in
            let newStart = geometry.frame(in: .global).origin
            let newEnd = CGPoint(x: newStart.x + geometry.size.width, y: newStart.y + geometry.size.height)
            
            let rotationAndScaling = CGAffineTransform(
                a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0
            ).concatenating(
                CGAffineTransform(scaleX: 1, y: 1)
            )
            let transformedStart = newStart.applying(rotationAndScaling)
            let transformedEnd = newEnd.applying(rotationAndScaling)
            
            let rotationAndScaling1 = CGAffineTransform(
                a: 0.01, b: 1, c: -0.86, d: 0, tx: 0.93, ty: 0
            ).concatenating(
                CGAffineTransform(scaleX: 1, y: 1)
            )
            let transformedStart1 = newStart.applying(rotationAndScaling1)
            let transformedEnd1 = newEnd.applying(rotationAndScaling1)
            
            let rotationAndScaling2 = CGAffineTransform(
                a: 0, b: 0.99, c: -1.11, d: 0, tx: 1.03, ty: 0.06
            ).concatenating(
                CGAffineTransform(scaleX: 1, y: 1)
            )
            let transformedStart2 = newStart.applying(rotationAndScaling2)
            let transformedEnd2 = newEnd.applying(rotationAndScaling2)
            
            let rotationAndScaling3 = CGAffineTransform(
                a: 1, b: -0.02, c: 0.02, d: 0.27, tx: -0.08, ty: 0.39
            ).concatenating(
                CGAffineTransform(scaleX: 1, y: 1)
            )
            let transformedStart3 = newStart.applying(rotationAndScaling3)
            let transformedEnd3 = newEnd.applying(rotationAndScaling3)

            
            ZStack {
                Bob()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1, green: 0.042, blue: 0, opacity: 0.1),
                            Color(red: 0.971, green: 0.546, blue: 0.322, opacity: 1)
                        ]),
                        startPoint: UnitPoint(x: 0.25, y: 0.5),
                        endPoint: UnitPoint(x: 0.75, y: 0.5)
                    ))
                    .opacity(0.8)
                    .overlay(
                        Bob()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.725, green: 0, blue: 1, opacity: 1),
                                    Color(red: 0.725, green: 0, blue: 1, opacity: 1),
                                    Color(red: 0.725, green: 0, blue: 1, opacity: 1),
                                    Color(red: 0.725, green: 0, blue: 1, opacity: 0),
                                    Color(red: 0.725, green: 0, blue: 1, opacity: 1)
                                ]),
                                startPoint: UnitPoint(x: transformedStart1.x / geometry.size.width, y: transformedStart1.y / geometry.size.height),
                                endPoint: UnitPoint(x: transformedEnd1.x / geometry.size.width, y: transformedEnd1.y / geometry.size.height)
                            ))
                            .opacity(0.2)
                        
                    )
                    .overlay(
                        Bob()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.254, green: 0.74, blue: 1, opacity: 0),
                                        Color(red: 0.254, green: 0.74, blue: 1, opacity: 1),
                                        Color(red: 0.254, green: 1, blue: 0.951, opacity: 1)
                                    ]),
                                    startPoint: UnitPoint(x: transformedStart.x / geometry.size.width, y: transformedStart.y / geometry.size.height),
                                    endPoint: UnitPoint(x: transformedEnd.x / geometry.size.width, y: transformedEnd.y / geometry.size.height)
                                )
                            )
                            .opacity(0.2)
                    )
                    .overlay(BobShadowView())
                
                BobOverlay()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1, green: 0.042, blue: 0, opacity: 0),
                            Color(red: 0.971, green: 0.546, blue: 0.322, opacity: 1)
                        ]),
                        startPoint: UnitPoint(x: transformedStart2.x / geometry.size.width, y: transformedStart2.y / geometry.size.height),
                        endPoint: UnitPoint(x: transformedEnd2.x / geometry.size.width, y: transformedEnd2.y / geometry.size.height)
                    ))
                    .opacity(0.05)
                    .overlay(
                        BobOverlay()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0, green: 0.394, blue: 0.985, opacity: 1),
                                    Color(red: 1, green: 1, blue: 1, opacity: 0.11)
                                ]),
                                startPoint: UnitPoint(x: transformedStart3.x / geometry.size.width, y: transformedStart3.y / geometry.size.height),
                                endPoint: UnitPoint(x: transformedEnd3.x / geometry.size.width, y: transformedEnd3.y / geometry.size.height)
                            ))
                            .opacity(0.1)

                    )
                    .overlay(BobShadowView())
                
                
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            SquigglyBobView()
        }
    }
}

struct Bob: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.6347*width, y: 0.3967*height))
        path.addCurve(to: CGPoint(x: 0.3097*width, y: 0.93531*height), control1: CGPoint(x: 0.8597*width, y: 0.61178*height), control2: CGPoint(x: 0.71595*width, y: 1.09707*height))
        path.addCurve(to: CGPoint(x: 0.96595*width, y: 0.10074*height), control1: CGPoint(x: -0.09655*width, y: 0.77354*height), control2: CGPoint(x: 0.9222*width, y: 0.31214*height))
        path.addCurve(to: CGPoint(x: 0.15345*width, y: 0.10074*height), control1: CGPoint(x: 1.0097*width, y: -0.11065*height), control2: CGPoint(x: 0.55625*width, y: 0.08088*height))
        path.addCurve(to: CGPoint(x: 0.6347*width, y: 0.3967*height), control1: CGPoint(x: -0.24935*width, y: 0.12061*height), control2: CGPoint(x: 0.4097*width, y: 0.18163*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.6347*width, y: 0.3967*height))
        path.addCurve(to: CGPoint(x: 0.3097*width, y: 0.93531*height), control1: CGPoint(x: 0.8597*width, y: 0.61178*height), control2: CGPoint(x: 0.71595*width, y: 1.09707*height))
        path.addCurve(to: CGPoint(x: 0.96595*width, y: 0.10074*height), control1: CGPoint(x: -0.09655*width, y: 0.77354*height), control2: CGPoint(x: 0.9222*width, y: 0.31214*height))
        path.addCurve(to: CGPoint(x: 0.15345*width, y: 0.10074*height), control1: CGPoint(x: 1.0097*width, y: -0.11065*height), control2: CGPoint(x: 0.55625*width, y: 0.08088*height))
        path.addCurve(to: CGPoint(x: 0.6347*width, y: 0.3967*height), control1: CGPoint(x: -0.24935*width, y: 0.12061*height), control2: CGPoint(x: 0.4097*width, y: 0.18163*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.6347*width, y: 0.3967*height))
        path.addCurve(to: CGPoint(x: 0.3097*width, y: 0.93531*height), control1: CGPoint(x: 0.8597*width, y: 0.61178*height), control2: CGPoint(x: 0.71595*width, y: 1.09707*height))
        path.addCurve(to: CGPoint(x: 0.96595*width, y: 0.10074*height), control1: CGPoint(x: -0.09655*width, y: 0.77354*height), control2: CGPoint(x: 0.9222*width, y: 0.31214*height))
        path.addCurve(to: CGPoint(x: 0.15345*width, y: 0.10074*height), control1: CGPoint(x: 1.0097*width, y: -0.11065*height), control2: CGPoint(x: 0.55625*width, y: 0.08088*height))
        path.addCurve(to: CGPoint(x: 0.6347*width, y: 0.3967*height), control1: CGPoint(x: -0.24935*width, y: 0.12061*height), control2: CGPoint(x: 0.4097*width, y: 0.18163*height))
        path.closeSubpath()
        return path
    }
}

struct BobOverlay: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9165*width, y: 0.54765*height))
        path.addCurve(to: CGPoint(x: 0.64194*width, y: 0.97049*height), control1: CGPoint(x: 0.70158*width, y: 0.77291*height), control2: CGPoint(x: 0.89137*width, y: 0.97049*height))
        path.addCurve(to: CGPoint(x: 0.16452*width, y: 0.53299*height), control1: CGPoint(x: 0.3925*width, y: 0.97049*height), control2: CGPoint(x: -0.24839*width, y: 0.70486*height))
        path.addCurve(to: CGPoint(x: 0.23871*width, y: 0.02257*height), control1: CGPoint(x: 0.57742*width, y: 0.36111*height), control2: CGPoint(x: -0.16621*width, y: 0.13782*height))
        path.addCurve(to: CGPoint(x: 0.9165*width, y: 0.54765*height), control1: CGPoint(x: 0.64363*width, y: -0.09268*height), control2: CGPoint(x: 1.13141*width, y: 0.32239*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.9165*width, y: 0.54765*height))
        path.addCurve(to: CGPoint(x: 0.64194*width, y: 0.97049*height), control1: CGPoint(x: 0.70158*width, y: 0.77291*height), control2: CGPoint(x: 0.89137*width, y: 0.97049*height))
        path.addCurve(to: CGPoint(x: 0.16452*width, y: 0.53299*height), control1: CGPoint(x: 0.3925*width, y: 0.97049*height), control2: CGPoint(x: -0.24839*width, y: 0.70486*height))
        path.addCurve(to: CGPoint(x: 0.23871*width, y: 0.02257*height), control1: CGPoint(x: 0.57742*width, y: 0.36111*height), control2: CGPoint(x: -0.16621*width, y: 0.13782*height))
        path.addCurve(to: CGPoint(x: 0.9165*width, y: 0.54765*height), control1: CGPoint(x: 0.64363*width, y: -0.09268*height), control2: CGPoint(x: 1.13141*width, y: 0.32239*height))
        path.closeSubpath()
        return path
    }
}

struct BobShadowView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let shadows = UIView()
        shadows.clipsToBounds = false

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        return shadows
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
