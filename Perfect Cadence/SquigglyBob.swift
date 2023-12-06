//
//  SquigglyBob.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 6/12/2023.
//


import SwiftUI

class SquigglyBob: ObservableObject {
    @Published var mainView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 150.9, height: 262.62)
        // Customize the main view if needed
        return view
    }()

    init() {
        setupUI()
    }

    func setupUI() {
        // Use the mainView as the base view for the components
        var view = mainView

        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

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

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CAGradientLayer()
        layer1.colors = [
            UIColor(red: 0.989, green: 0.991, blue: 0.867, alpha: 1).cgColor,
            UIColor(red: 0.99, green: 1, blue: 0.487, alpha: 1).cgColor,
            UIColor(red: 0.835, green: 0.96, blue: 1, alpha: 1).cgColor
        ]
        layer1.locations = [0, 0.5, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 0.99, c: -1.11, d: 0, tx: 1.03, ty: 0.06))
        layer1.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)

        let layer2 = CAGradientLayer()
        layer2.colors = [
            UIColor(red: 0, green: 0.394, blue: 0.985, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.11).cgColor
        ]
        layer2.locations = [0, 1]
        layer2.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer2.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer2.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: -0.02, c: 0.02, d: 0.27, tx: -0.08, ty: 0.39))
        layer2.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
        layer2.position = shapes.center
        shapes.layer.addSublayer(layer2)

        var parent = mainView.superview
        parent?.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

struct MySwiftUIView: UIViewRepresentable {
    @ObservedObject var viewModel: SquigglyBob

    func makeUIView(context: Context) -> UIView {
        return viewModel.mainView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}

struct ContentView: View {
    @StateObject var viewModel = SquigglyBob()

    var body: some View {
        VStack {
            // Use the UIViewRepresentable to integrate the UIKit view into SwiftUI
            MySwiftUIView(viewModel: viewModel)
                .frame(width: 150.9, height: 262.62)
        }
    }
}




//import SwiftUI
//
//struct SquigglyBob: View {
//    var body: some View {
//        Bob()
//            .foregroundStyle(.linearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: UnitPoint.bottomTrailing))
//        
//    }
//}
//
//#Preview {
//    SquigglyBob()
//}
//
//
//
//struct Bob: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.size.width
//        let height = rect.size.height
//        path.move(to: CGPoint(x: 0.60015*width, y: 0.45371*height))
//        path.addCurve(to: CGPoint(x: 0.29246*width, y: 0.94204*height), control1: CGPoint(x: 0.81317*width, y: 0.64871*height), control2: CGPoint(x: 0.67707*width, y: 1.08871*height))
//        path.addCurve(to: CGPoint(x: 0.91376*width, y: 0.18538*height), control1: CGPoint(x: -0.09216*width, y: 0.79538*height), control2: CGPoint(x: 0.87234*width, y: 0.37705*height))
//        path.addCurve(to: CGPoint(x: 0.14453*width, y: 0.18538*height), control1: CGPoint(x: 0.95518*width, y: -0.00629*height), control2: CGPoint(x: 0.52588*width, y: 0.16737*height))
//        path.addCurve(to: CGPoint(x: 0.60015*width, y: 0.45371*height), control1: CGPoint(x: -0.23682*width, y: 0.20339*height), control2: CGPoint(x: 0.38713*width, y: 0.25871*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.60015*width, y: 0.45371*height))
//        path.addCurve(to: CGPoint(x: 0.29246*width, y: 0.94204*height), control1: CGPoint(x: 0.81317*width, y: 0.64871*height), control2: CGPoint(x: 0.67707*width, y: 1.08871*height))
//        path.addCurve(to: CGPoint(x: 0.91376*width, y: 0.18538*height), control1: CGPoint(x: -0.09216*width, y: 0.79538*height), control2: CGPoint(x: 0.87234*width, y: 0.37705*height))
//        path.addCurve(to: CGPoint(x: 0.14453*width, y: 0.18538*height), control1: CGPoint(x: 0.95518*width, y: -0.00629*height), control2: CGPoint(x: 0.52588*width, y: 0.16737*height))
//        path.addCurve(to: CGPoint(x: 0.60015*width, y: 0.45371*height), control1: CGPoint(x: -0.23682*width, y: 0.20339*height), control2: CGPoint(x: 0.38713*width, y: 0.25871*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.60015*width, y: 0.45371*height))
//        path.addCurve(to: CGPoint(x: 0.29246*width, y: 0.94204*height), control1: CGPoint(x: 0.81317*width, y: 0.64871*height), control2: CGPoint(x: 0.67707*width, y: 1.08871*height))
//        path.addCurve(to: CGPoint(x: 0.91376*width, y: 0.18538*height), control1: CGPoint(x: -0.09216*width, y: 0.79538*height), control2: CGPoint(x: 0.87234*width, y: 0.37705*height))
//        path.addCurve(to: CGPoint(x: 0.14453*width, y: 0.18538*height), control1: CGPoint(x: 0.95518*width, y: -0.00629*height), control2: CGPoint(x: 0.52588*width, y: 0.16737*height))
//        path.addCurve(to: CGPoint(x: 0.60015*width, y: 0.45371*height), control1: CGPoint(x: -0.23682*width, y: 0.20339*height), control2: CGPoint(x: 0.38713*width, y: 0.25871*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.92266*width, y: 0.52311*height))
//        path.addCurve(to: CGPoint(x: 0.67085*width, y: 0.92904*height), control1: CGPoint(x: 0.72555*width, y: 0.73936*height), control2: CGPoint(x: 0.89962*width, y: 0.92904*height))
//        path.addCurve(to: CGPoint(x: 0.23298*width, y: 0.50904*height), control1: CGPoint(x: 0.44208*width, y: 0.92904*height), control2: CGPoint(x: -0.14572*width, y: 0.67404*height))
//        path.addCurve(to: CGPoint(x: 0.30103*width, y: 0.01904*height), control1: CGPoint(x: 0.61167*width, y: 0.34404*height), control2: CGPoint(x: -0.07035*width, y: 0.12968*height))
//        path.addCurve(to: CGPoint(x: 0.92266*width, y: 0.52311*height), control1: CGPoint(x: 0.6724*width, y: -0.0916*height), control2: CGPoint(x: 1.11978*width, y: 0.30686*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.92266*width, y: 0.52311*height))
//        path.addCurve(to: CGPoint(x: 0.67085*width, y: 0.92904*height), control1: CGPoint(x: 0.72555*width, y: 0.73936*height), control2: CGPoint(x: 0.89962*width, y: 0.92904*height))
//        path.addCurve(to: CGPoint(x: 0.23298*width, y: 0.50904*height), control1: CGPoint(x: 0.44208*width, y: 0.92904*height), control2: CGPoint(x: -0.14572*width, y: 0.67404*height))
//        path.addCurve(to: CGPoint(x: 0.30103*width, y: 0.01904*height), control1: CGPoint(x: 0.61167*width, y: 0.34404*height), control2: CGPoint(x: -0.07035*width, y: 0.12968*height))
//        path.addCurve(to: CGPoint(x: 0.92266*width, y: 0.52311*height), control1: CGPoint(x: 0.6724*width, y: -0.0916*height), control2: CGPoint(x: 1.11978*width, y: 0.30686*height))
//        path.closeSubpath()
//        return path
//    }
//}
//
//
//
//


//
//struct bob: Shape {
//
//    var view = UIView()
//    view.frame = CGRect(x: 0, y: 0, width: 150.9, height: 262.62)
//    var shadows = UIView()
//    shadows.frame = view.frame
//    shadows.clipsToBounds = false
//    view.addSubview(shadows)
//
//    let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
//    let layer0 = CALayer()
//    layer0.shadowPath = shadowPath0.cgPath
//    layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//    layer0.shadowOpacity = 1
//    layer0.shadowRadius = 4
//    layer0.shadowOffset = CGSize(width: 0, height: 4)
//    layer0.bounds = shadows.bounds
//    layer0.position = shadows.center
//    shadows.layer.addSublayer(layer0)
//
//    var shapes = UIView()
//    shapes.frame = view.frame
//    shapes.clipsToBounds = true
//    view.addSubview(shapes)
//
//    let layer1 = CAGradientLayer()
//    layer1.colors = [
//        UIColor(red: 1, green: 0.042, blue: 0, alpha: 0).cgColor,
//        UIColor(red: 0.971, green: 0.546, blue: 0.322, alpha: 1).cgColor
//    ]
//    layer1.locations = [0, 1]
//    layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
//    layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
//    layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.01, b: 0.95, c: -1.5, d: 0.01, tx: 0.94, ty: -0.07))
//    layer1.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//    layer1.position = shapes.center
//    shapes.layer.addSublayer(layer1)
//
//    let layer2 = CAGradientLayer()
//    layer2.colors = [
//        UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//        UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//        UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor,
//        UIColor(red: 0.725, green: 0, blue: 1, alpha: 0).cgColor,
//        UIColor(red: 0.725, green: 0, blue: 1, alpha: 1).cgColor
//    ]
//    layer2.locations = [1, 1, 1, 1, 1]
//    layer2.startPoint = CGPoint(x: 0.25, y: 0.5)
//    layer2.endPoint = CGPoint(x: 0.75, y: 0.5)
//    layer2.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.01, b: 1, c: -0.86, d: 0, tx: 0.93, ty: 0))
//    layer2.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//    layer2.position = shapes.center
//    shapes.layer.addSublayer(layer2)
//
//    let layer3 = CAGradientLayer()
//    layer3.colors = [
//        UIColor(red: 0.254, green: 0.74, blue: 1, alpha: 0).cgColor,
//        UIColor(red: 0.254, green: 0.74, blue: 1, alpha: 1).cgColor,
//        UIColor(red: 0.254, green: 1, blue: 0.951, alpha: 1).cgColor
//    ]
//    layer3.locations = [0, 1, 1]
//    layer3.startPoint = CGPoint(x: 0.25, y: 0.5)
//    layer3.endPoint = CGPoint(x: 0.75, y: 0.5)
//    layer3.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
//    layer3.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
//    layer3.position = shapes.center
//    shapes.layer.addSublayer(layer3)
//
//
//    var parent = self.view!
//    parent.addSubview(view)
//    view.translatesAutoresizingMaskIntoConstraints = false
//}
