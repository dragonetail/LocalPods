//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

struct CellModel {
    var name: String
    var company: String
    var content: String
    var cacheHeight: CGFloat

    static func load() -> [CellModel] {
        guard let resourcePath = Bundle.main.path(forResource: "SampleData", ofType: "plist"),
            let array = NSArray.init(contentsOfFile: resourcePath) as? [NSDictionary] else {
                return [CellModel]()
        }

        var models = [CellModel]()
        array.forEach({ (dict) in
            let name = dict["sampleName"] as! String
            let company = dict["sampleCompany"] as! String
            let content = dict["simpleContent"] as! String

            let model = CellModel(name: name, company: company, content: content, cacheHeight: 0)
            models.append(model)
        })
        return models
    }
}

class CodeLayoutCell: UITableViewCell {
    lazy var cellImageView: UIImageView = {
        let cellImageView = UIImageView().configureForAutoLayout("cellImageView")
        cellImageView.image = UIImage(named: "kakaxi")
        return cellImageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel().configureForAutoLayout("nameLabel")

        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black;
        label.font = UIFont.systemFont(ofSize: 14);
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left;

        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel().configureForAutoLayout("contentLabel")

        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black;
        label.font = UIFont.systemFont(ofSize: 12);
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        //label.lineBreakMode = .byClipping
        label.textAlignment = .left;

        return label
    }()
    lazy var companyLabel: UILabel = {
        let label = UILabel().configureForAutoLayout("companyLabel")

        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black;
        label.font = UIFont.systemFont(ofSize: 10);
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left;

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _ = self.configureForAutoLayout("CodeLayoutCell")

        setupAndComposeView()

        // bootstrap Auto Layout
        self.setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Should overritted by subclass, setup view and compose subviews
    func setupAndComposeView() {
        [cellImageView, nameLabel, contentLabel, companyLabel].forEach { (subview) in
            self.contentView.addSubview(subview)
        }
    }

    fileprivate var didSetupConstraints = false
    override func updateConstraints() {
        if (!didSetupConstraints) {
            didSetupConstraints = true
            setupConstraints()
        }
        //modifyConstraints()

        super.updateConstraints()
    }

    // invoked only once
    func setupConstraints() {

        //图片距左边距离为10，上下居中
        cellImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        //cellImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        cellImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        cellImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10, relation: .greaterThanOrEqual)

        //标题Label,一行显示
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        nameLabel.autoPinEdge(.left, to: .right, of: cellImageView, withOffset: 6)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10, relation: .greaterThanOrEqual)

        //内容label,多行显示
        contentLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 6)
        contentLabel.autoPinEdge(.left, to: .left, of: nameLabel)
        contentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)

        //标题Label,一行显示
        companyLabel.autoPinEdge(.top, to: .bottom, of: contentLabel, withOffset: 6)
        companyLabel.autoPinEdge(.left, to: .left, of: nameLabel)
        companyLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10, relation: .greaterThanOrEqual)
        companyLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10, relation: .greaterThanOrEqual)

        // Prevent the two UILabels from being compressed below their intrinsic content height
        NSLayoutConstraint.autoSetPriority(UILayoutPriority(rawValue: 249)) {
            self.contentLabel.autoSetContentHuggingPriority(for: .vertical)
            self.companyLabel.autoSetContentHuggingPriority(for: .vertical)
        }

        NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
            self.cellImageView.autoSetContentCompressionResistancePriority(for: .horizontal)
            self.cellImageView.autoSetContentCompressionResistancePriority(for: .vertical)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setLabelText(model: CellModel) {
        nameLabel.text = model.name
        contentLabel.text = model.content
        companyLabel.text = model.company
    }
}

class CodeTableViewController: BaseViewControllerWithAutolayout {
    static let cellIdentifier = String(describing: CodeLayoutCell.self)

    var data: [CellModel] = CellModel.load()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero).configureForAutoLayout("tableView")
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CodeLayoutCell.self, forCellReuseIdentifier: CodeTableViewController.cellIdentifier)
        //Sure the table view use auto layout
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        return tableView
    }()

    override var accessibilityIdentifier: String {
        return "CodeTableVC"
    }

    override func setupAndComposeView() {
        self.title = "纯代码布局tablecell"

        view.addSubview(tableView)
    }

    override func setupConstraints() {
        tableView.autoPinEdgesToSuperviewEdges()
    }
}

extension CodeTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CodeTableViewController.cellIdentifier, for: indexPath) as! CodeLayoutCell

        let model = data[indexPath.row]
        cell.setLabelText(model: model)
        // Make sure the constraints have been added to this cell, since it may have just been created from scratch
        //cell.setNeedsUpdateConstraints()
        //cell.updateConstraintsIfNeeded()

        return cell
    }
}
extension CodeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CodeLayoutCell

        var model = data[indexPath.row]
        switch Int.random(in: 0...1) {
        case 0:
            model.content = model.content +
                " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Hi, this is a test!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Hi, this is a test!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Hi, this is a test!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Hi, this is a test!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        default:
            model.content = "Hi ~ \(Int.random(in: 1...99999))"
        }
        //data[indexPath.row] = model
        tableView.beginUpdates()
        cell.setLabelText(model: model)
        UIView.animate(withDuration: 0.5) {
            tableView.endUpdates()
        }
    }
}

