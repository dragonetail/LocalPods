//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample8ViewController: BaseViewControllerWithAutolayout {
    lazy var containerView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var blueView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .blue
        return view
    }()
    lazy var redView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .red
        return view
    }()
    lazy var yellowView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .yellow
        return view
    }()
    lazy var greenView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .green
        return view
    }()

    override var accessibilityIdentifier: String {
        return "E8"
    }
    override func setupAndComposeView() {
        self.title = "8.Constraint Identifiers (iOS 7.0+)"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        view.addSubview(containerView)
        [blueView, redView, yellowView, greenView].forEach { (subview) in
            containerView.addSubview(subview)
        }
    }

    override func setupConstraints() {
        /**
         First, we'll set up some 'good' constraints that work correctly.
         Note that we identify all of the constraints with a short description of what their purpose is - this is a great feature
         to help you document and comment constraints both in the code, and at runtime. If a Required constraint is ever broken,
         it will raise an exception, and you will see these identifiers show up next to the constraint in the console.
         */

        NSLayoutConstraint.autoSetIdentifier("Pin Container View Edges") {
            self.containerView.autoPin(toTopLayoutGuideOf: self, withInset: 10.0)
            self.containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0), excludingEdge: .top)
        }

        let views: NSArray = [redView, blueView, yellowView, greenView]

        (views.autoDistributeViews(along: .vertical, alignedTo: .vertical, withFixedSize: 40.0) as NSArray).autoIdentifyConstraints("Distribute Views Vertically")

        /**
         Note that the -autoIdentify and -autoIdentifyConstraints methods set the identifier, and then return the constraint(s).
         This lets you chain the identifier call right after creating the constraint(s), and still capture a reference to the constraint(s)!
         */

        let constraints = (views.autoSetViewsDimension(.width, toSize: 60.0) as NSArray).autoIdentifyConstraints("Set Width of All Views")
        print("Just added \(constraints.count) constraints!") // you can do something with the constraints at this point
        let constraint = redView.autoAlignAxis(toSuperviewAxis: .vertical).autoIdentify("Align Red View to Superview Vertical Axis")
        print("Just added one constraint with the identifier: \(String(describing: constraint.identifier))") // you can do something with the constraint at this point

        /**
         Now, let's add some 'bad' constraints that conflict with one or more of the 'good' constraints above.
         Start by uncommenting one of the below constraints, and running the demo. A constraint exception will be logged
         to the console, because one or more views was over-constrained, and therefore one or more constraints had to be broken.
         But because we have provided human-readable identifiers, notice how easy it is to figure out which constraints are
         conflicting, and which constraint shouldn't be there!
         */
        NSLayoutConstraint.autoSetIdentifier("Bad Constraints That Break Things") {
            //self.redView.autoAlignAxis(.vertical, toSameAxisOf: self.view, withOffset: 5.0) // uncomment me and watch things blow up!

            //                self.redView.autoPinEdgeToSuperviewEdge(.Left) // uncomment me and watch things blow up!

            //                views.autoSetViewsDimension(.Height, toSize: 50.0) // uncomment me and watch things blow up!
        }
    }

}
