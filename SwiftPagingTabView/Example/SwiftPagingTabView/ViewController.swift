import UIKit
import SwiftPagingTabView
import SwiftBaseBootstrap

class ViewController: BaseViewControllerWithAutolayout {

    public lazy var pagingTabView: PagingTabView = {
        let pagingTabView: PagingTabView = PagingTabView().autoLayout("pagingTabView")
        pagingTabView.config = PagingTabViewConfig()
        pagingTabView.delegate = self
        pagingTabView.datasource = self

        return pagingTabView
    }()
    public lazy var commandView: CommandView = {
        let view = CommandView().autoLayout("commandView")
        view.pagingTabView = pagingTabView
        return view
    }()

    override open func setupAndComposeView() {
        self.view.addSubview(pagingTabView)

        pagingTabView.setupAndComposeView()
    }

    override open func setupConstraints() {
        pagingTabView.autoPinEdgesToSuperviewSafeArea()
    }
}
extension ViewController: PagingTabViewDelegate {
    func pagingTabView(pagingTabView: PagingTabView, toIndex: Int) {
        print("Switch to paging tab view: \(toIndex)")
    }

    func reconfigure(pagingTabView: PagingTabView) {
        pagingTabView.tabButtons.forEach { (tabButton) in
            tabButton.config = TabButtonConfig()
        }
    }
}
extension ViewController: PagingTabViewDataSource {
    func segments(pagingTabView: PagingTabView) -> Int {
        return 4
    }

    func tabTitle(pagingTabView: PagingTabView, index: Int) -> (image: UIImage?, title: String?) {
        if commandView.isEnableImageTitle {
            return (image: UIImage(named: "menu"),
                    title: "TAB标签_" + String(index))
        } else {
            return (image: nil,
                    title: "TAB标签_" + String(index))
        }
    }

    func tabView(pagingTabView: PagingTabView, index: Int) -> UIView {
        if index == 0 {
            return commandView.autoLayout("commandView")
        } else {
            let view = UILabel().autoLayout("View_\(index)")
            view.backgroundColor = UIColor.white
            view.text = "View " + String(index)
            view.textAlignment = .center
            return view
        }
    }
}

class CommandView: BaseViewWithAutolayout {
    var isEnableImageTitle: Bool = false {
        didSet {
            if isEnableImageTitle {
                enableImageTitleButton.setTitle("Disable Image Tab Title", for: .normal)
            } else {
                enableImageTitleButton.setTitle("Enable Image Tab Title", for: .normal)
            }
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel().autoLayout("label")
        label.text = "Hi, nice to meet you ~"
        return label
    }()
    private lazy var enableImageTitleButton: UIButton = {
        let button = UIButton(type: .system).autoLayout("enableImageTitleButton")
        button.setTitle("Enable Image Tab Title", for: .normal)
        button.addTarget(self, action: #selector(CommandView.buttonTapped(sender:)), for: .touchUpInside)

        return button
    }()

    var pagingTabView: PagingTabView?
    @objc internal func buttonTapped(sender: UIButton) {
        isEnableImageTitle = !isEnableImageTitle

        pagingTabView?.setupAndComposeView()
    }

    override open func setupAndComposeView() {
        [label, enableImageTitleButton].forEach({
            addSubview($0)
        })
    }

    override open func setupConstraints() {
        label.autoCenterInSuperview()

        enableImageTitleButton.autoAlignAxis(toSuperviewAxis: .vertical)
        enableImageTitleButton.autoPinEdge(.top, to: .bottom, of: label, withOffset: 15)
    }
}
