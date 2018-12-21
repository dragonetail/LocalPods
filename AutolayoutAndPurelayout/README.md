#  Autolayout和Purelayout最佳实践

## 目标

整理和学习Autolayout和Purelayout的概念，梳理关联的例子程序，联系掌握各种实用手法，确定使用Autolayout的最佳实践。



------

## 例子

目前整理了Purelayout的官方例子，对于Swift4.2进行了调整，同时针对各种讨论总结整理的最佳实践进行了调整，作为实用Autolayout和Purelayout的参考模板。

| 例子                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [尺寸拉伸](./AutolayoutAndPurelayout/IntrinsicContentSize/HuggingExampleViewController.swift) | 使用 ContentHuggingPriority的例子                            |
| [尺寸压缩](./AutolayoutAndPurelayout/IntrinsicContentSize/CompressionExampleViewController.swift) | 使用 ContentCompressionResistancePriority的例子              |
| [Table图片+多行文字](./AutolayoutAndPurelayout/IntrinsicContentSize/CodeTableViewController.swift) | 使用 TableView和定制Cell，构造左侧图片，右侧多行文本，其中一个多行自动计算单元格高度；同时包含了从plist中读取xml数据的示例；以及动态更改TableView中Cell的Label内容，包括高度自动计算和动画控制。 |
| [Dynamic Stack View](./AutolayoutAndPurelayout/AppleSample/DynamicStackViewController.swift) | Apple官方文档例子实现，使用 UIScrollView、 UIStackView和Purelayout实现动态内容管理，模拟实现TableView的效果。 |
| [1.Basic Auto Layout](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample1ViewController.swift) | Purelayout官方例子，基础布局。                               |
| [2.Working with Arrays of Views](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample2ViewController.swift) | Purelayout数组批量布局。                                     |
| [3.Distributing Views](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample3ViewController.swift) | Purelayout数组批量分布布局（ autoDistributeViews）。         |
| [ 4.Leading & Trailing Attributes](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample4ViewController.swift) | Purelayout考虑阅读方向进行布局。                             |
| [5.Cross-Attribute Constraints](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample5ViewController.swift) | Purelayout组件交叉重叠，使用轴线（Axis）布局。               |
| [6.Priorities & Inequalities](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample6ViewController.swift) | Purelayout用约束的 relation和 priority构建一个正方形。       |
| [7.Animating Constraints](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample7ViewController.swift) | Purelayout约束初始化和更新的示例，用动画显示约束的变化。作为最佳实践抽象，演示了 setupConstraints() 、modifyConstraints() 配合约束变量使用的模板，同时演示了约束中 constant的动态变化操作。 |
| [8.Constraint Identifiers (iOS 7.0+)](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample8ViewController.swift) | 演示了Purelayout的autoIdentifyConstraints，对约束进行ID化操作，方便信息查看。具体参见Autolayout调试章节关联描述。 |
| [9.Layout Margins (iOS 8.0+)](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample9ViewController.swift) | 演示Purelayout使用Margin的约束。这个示例的效果有一点小问题，内嵌时效果与预想不一致，有待调查。 |
| [10.Constraints Without Installing](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample10ViewController.swift) | Purelayout另外一个控制约束的例子，使用 autoInstallConstraints、 autoRemoveConstraints（实际是无效）、 autoCreateAndInstallConstraints和 autoCreateConstraintsWithoutInstalling来动态控制约束变化。（Purelayout中这几个方法的名字有点小问题，实际是创建约束后是否有效的控制） |
| [11.Basic UIScrollView](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample11ViewController.swift) | Purelayout对ScrollView、Label处理多行文字，自动化高度的布局处理示例。 |
| [12.Basic Auto Layout with Constraint toggle](./AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample12ViewController.swift) | 另外一个非官方的演示约束constant的动态控制变化的例子。       |



------

## 使用Autolayout和Purelayout的最佳实践

构建UIViewController和UIView使用Purelayout的最佳模板，主要针对初始化和约束部分进行。

### UIViewController的最佳实践

1、在Controller及其View，由于系统已经在布局尺寸上进行了合理化处理，不要试图使用Autolayout对齐直接视图进行管理，老老实实让AutoresizingMask在Controller的View上生成对应Frame尺寸的约束，对Controller的下层View再使用Autolayout模式，即对Controller的subviews都可以使用Autolayout模式，但是对Controller不要使用。

2、在onload初始化时需要设置translatesAutoresizingMaskIntoConstraints为True明确对AutoresizingMask模式进行配置。

3、同时设置accessibilityIdentifier，约束输出信息的显示的可阅读性。关于accessibilityIdentifier的设置方法，可以使用本地化只读计算变量进行设置，参见[BaseViewControllerWithAutolayout.swift](./AutolayoutAndPurelayout/BaseViewControllerWithAutolayout.swift)。

上面2和3的部分可以参见如下扩展代码实现，调用位置，应该在onload方法super.onload()调用后，参见[BaseViewControllerWithAutolayout.swift](./AutolayoutAndPurelayout/BaseViewControllerWithAutolayout.swift)

```swift
extension UIView {
    func configureForAutoresizingMask(_ accessibilityIdentifier: String? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = true;
        if let accessibilityIdentifier = accessibilityIdentifier {
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        return self
    }
}

```

4、在onload()结束之后，应该调用view.setNeedsUpdateConstraints()方法激活Autolayout模式，让视图在显示环节调用updateViewConstraints()计算约束。

5、对updateViewConstraints()进行实现，通过变量进行初始化约束设置和变化更新约束设置，参见[BaseViewControllerWithAutolayout.swift](./AutolayoutAndPurelayout/BaseViewControllerWithAutolayout.swift)。

6、在updateViewConstraints()最后调用 super.updateViewConstraints()执行约束的验证和计算。

7、在需要的地方，例如viewDidLayoutSubviews()中打印当前视图和父视图的约束信息，或者添加print(self.view.value(forKey: "_autolayoutTrace"))打印视图调用堆栈信息。

8、如果继承基础的UIViewController，建议使用[BaseViewControllerWithAutolayout.swift](./AutolayoutAndPurelayout/BaseViewControllerWithAutolayout.swift)，直接集成了上面的最佳实践内容和调试内容。

9、Controller中SubView，在构造结束后，统一使用configureForAutoLayout("blueView")设置translatesAutoresizingMaskIntoConstraints为False同时设置约束显示时SubView的ID。

configureForAutoLayout()的定义：

```swift
extension UIView {
    func configureForAutoLayout(_ accessibilityIdentifier: String? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false;
        if let accessibilityIdentifier = accessibilityIdentifier {
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        return self
    }
}
```

10、继承[BaseViewControllerWithAutolayout.swift](./AutolayoutAndPurelayout/BaseViewControllerWithAutolayout.swift)的Controller主要内容示例如下：

```swift
class PurelayoutExample1ViewController: BaseViewControllerWithAutolayout {
    lazy var blueView: UIView = {
        let view = UIView().configureForAutoLayout("blueView")
        view.backgroundColor = .blue
        return view
    }()
    ...
    
    override var accessibilityIdentifier: String {
        return "E1" //定义UIViewController的View的约束ID
    }

    override func setupAndComposeView() {
        self.title = "Basic Auto Layout"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, yellowView, greenView].forEach { (subview) in
            view.addSubview(subview)
        }
    }

    override func setupConstraints() {
        blueView.autoCenterInSuperview()
  		...
    }
```



### UIView的最佳实践

1、在Controller中使用构建的SubView，需要依据Controller的第9个最佳实践规则调用configureForAutoLayout("blueView")进行Autolyout初始化的ID设置。

2、对于继承UIView类的子类封装，可以参考BaseViewWithAutolayout.swift的实现进行：

也可以参考例子[Table图片+多行文字](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/IntrinsicContentSize/CodeTableViewController.swift)的实现。

```swift
class BaseViewWithAutolayout: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = self.configureForAutoLayout("BaseViewWAL")

        setupAndComposeView()

        // bootstrap Auto Layout
        self.setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Should overritted by subclass, setup view and compose subviews
    func setupAndComposeView() {
    }

    fileprivate var didSetupConstraints = false
    override func updateConstraints() {
        if (!didSetupConstraints) {
            didSetupConstraints = true
            setupConstraints()
        }
        modifyConstraints()

        super.updateConstraints()
    }

    // invoked only once
    func setupConstraints() {
    }
    func modifyConstraints() {
    }
}
```





------

## Autolayout调试

### 视图堆栈

使用下面语句可以打印视图堆栈。

```swift
在程序中
print(self.view.value(forKey: "_autolayoutTrace"))
或者在中断时，lldb窗口
po print(self.view.value(forKey: "_autolayoutTrace"))
或者在中断时，在lldb窗口
expr -l objc++ -O -- [[UIWindow keyWindow] _autolayoutTrace]
```

### 打印Contraints内容

使用下面语句可以打印视图的约束内容。

```swift
在程序中
self.view.printConstraints()
self.view.superview?.printConstraints()
或者在中断时，lldb窗口
po self.view.printConstraints()
po self.view.superview?.printConstraints()
```

printConstraints()的实现，参见UIView+Extension.swift

```swift
extension UIView {
    func printConstraints() {
        #if DEBUG
        self.constraints.forEach { (constraint) in
            print(String(describing: constraint))
        }
        #endif
    }
    
    func roundBorder(_ color: UIColor = UIColor.purple) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        layer.cornerRadius = 3
        clipsToBounds = true
    }
}
```

### 空间边框辅助调试

对于问题View使用上面UIView扩展的roundBorder，添加在代码中既可以方便在画面上对需要的视图添加边框方便调试。

### 模拟执行layout

可以配合setNeedsUpdateConstraints使用。

```swift
或者或者在中断时，在lldb窗口，执行如下命令，会尝试重新Layout调用。
(lldb) po self.view.exerciseAmbiguityInLayout()
10.Constraints Without Installing viewWillLayoutSubviews~~~
10.Constraints Without Installing viewWillLayoutSubviews...
10.Constraints Without Installing viewDidLayoutSubviews~~~
10.Constraints Without Installing viewDidLayoutSubviews...
(lldb) po self.view.setNeedsUpdateConstraints()
(lldb) po self.view.exerciseAmbiguityInLayout()
10.Constraints Without Installing viewWillLayoutSubviews~~~
10.Constraints Without Installing viewWillLayoutSubviews...
10.Constraints Without Installing updateViewConstraints~~~
10.Constraints Without Installing modifyConstraints.
10.Constraints Without Installing updateViewConstraints...
10.Constraints Without Installing viewDidLayoutSubviews~~~
10.Constraints Without Installing viewDidLayoutSubviews...
```

### 在Xcode中，当Autolayout出现冲突是添加中断

需要在`UIViewAlertForUnsatisfiableConstraints`添加`symbolic breakpoint`：

> 1.打开Debug->Breakpoints->Create symbolic breakpoin
>
> 2.在`Symbol`中添加`UIViewAlertForUnsatisfiableConstraints`
>
> 3.在Action点击Add Action，类型选择`Debugger Command`，内容填写`expr -l objc++ -O -- [[UIWindow keyWindow] _autolayoutTrace]`。

再次出现约束冲突的时候，就可以在终端显示视图堆栈，也可以在中断时执行其他动作进一步处理。

### 在代码实现的时候，对View添加accessibilityIdentifier提升调试信息可读性

具体参见最佳实践章节。

### 在代码实现的时候，对约束添加Identifier提升调试信息可读性

具体参见示例[8.Constraint Identifiers (iOS 7.0+)](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample8ViewController.swift)。



------

## Autolayout处理流程基础概念

Auto Layout追加了两个步骤在视图显示的过程中：updating constraints（约束更新） and laying out views（视图布局）。整个过程行程了依赖处理链条，视图显示依赖视图布局、布局依赖约束更新。

**约束更新（updating constraints）**是一个自底向上（bottom-up ）从子视图到（subview）父视图（super view）尺寸计算的环节，为视图布局准备尺寸定义和计算信息，最后传给布局的尺寸（frame）实际设计布局。定制化视图的约束处理，重载实现视图的 `updateConstraints` 方法追加本视图处理阶段需要的特殊约束定制；当时图中内容发生变化时，例如部分组件移动位置，组件增加减少时，可以通过 `setNeedsUpdateConstraints`通知视图布局变化。（这个动作会由系统延后进行处理，激活调用 `updateConstraints` 。这个需要验证。）

**视图布局（view layout）**是一个自上而下（top-down），从父视图到子视图（from super view to subview）的处理过程，这个过程实际将视图约束应用到视图尺寸（frame）上（对于OS X系统）或者视图的中心和边界（center and bounds，对于iOS系统）。当视图需要更新布局，调用 `setNeedsLayout`可以出发系统重新布局处理，这个调用可以根据布局组件变化多次调用，系统会合并多次调用并稍后处理。如果希望立即更新布局，可以调用 `layoutIfNeeded`/`layoutSubtreeIfNeeded` (分别对应 iOS 和 OS X=)，如果你下一步的工作依赖于视图的布局尺寸（Frame），这会立即更新视图尺寸。定制视图的话，通过重载`layoutSubviews`/`layout` 来实现布局过程的细节。

**视图显示**，最后显示环节将根据布局信息进行自上而下（top-down）的视图渲染。可以调用`setNeedsDisplay`,来激活这个过程，这个系统也会合并多次调用并稍后处理。通过重载 `drawRect` 可以来定制视图显示处理的细节。

**视图显示->视图布局->约束更新**，是进行链式依赖的，视图显示会看是否有layout的变化需要更新（是否有过系统或者定制处理调用的 `setNeedsLayout`），同样视图布局会依赖约束更新，检查约束是否有变化过需要重新计算。

**注意**：上面这个依赖链不是一个单向通道，可能会是一个迭代的处理过程。视图布局环节可能做了一些变化需要激活重新计算约束更新，约束更新重新计算会重新触发试图布局，这种机制可以让你有能力创造复杂高级的视图布局，但也会让你在 `layoutSubviews` 和 `updateConstraints` 之间轻松陷入死循环。



**【汇总说明】**必须明确AutoLayout关于更新的几个方法的区别

- setNeedsLayout：告知系统画面需要更新，但是不会立刻开始更新。执行后系统会稍后立刻调用layoutSubviews。
- layoutIfNeeded：告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
- layoutSubviews：系统执行布局重新处理，使用Autolayout的情况基本不需要特殊工作。
- setNeedsUpdateConstraints：告知系统需要更新约束，但是不会立刻开始，等到下一次layout过程会被执行
- updateConstraintsIfNeeded：告知立刻重新计算更新约束
- updateConstraints：系统计算更新约束，使用Autolayout需要重点实现的部分。这个方法在视图生命周期可能会被多次调用，但是相同的或者互相影响的约束多次被计算会导致性能或者冲突问题，因此需要区分初始化设置和变化部分，变化部分需要考虑同事件和组件的关联处理，以及屏幕旋转的处理等。这部分已经抽象到基础类，设计setupConstraints() 、modifyConstraints() 两个方法让子类去继承实现，详细参见Autolayout最佳实践章节。



## Auto Layout定制化视图的概念

Auto Layout定制化视图处理需要处理：计算内部内容期望尺寸显示大小、理解视图尺寸和对齐矩阵、使用基线布局、同Layout处理流程交互。

### 内容期望尺寸（Intrinsic Content Size）

内容期望尺寸是对将要显示的内容，你希望预期显示的尺寸。例如对于`UILabel`会根据字体有期望显示的高度，根据字体和显示文字的内容有期望的宽度；  `UIProgressView` 根据设计有期望显示的高度，但是不会有宽度；普通的`UIVIew`通常既没有期望的显示高度和宽度。

如果你的视图需要使用内容期望尺寸，就需要在高度和宽度两个维度进行指定。通过重载[`intrinsicContentSize`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/intrinsicContentSize) 计算内容期望尺寸，通过调用 [`invalidateIntrinsicContentSize`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/invalidateIntrinsicContentSize) 来触发需要重新计算。如果结果只有一个维度，对于没有的维度返回常量`UIViewNoIntrinsicMetric`/`NSViewNoIntrinsicMetric`告知系统。

**注意：**内容期望尺寸计算必须独立不依赖视图尺寸。例如不可以通过视图显示区域尺寸的大小返回一个比例尺寸。

#### 抗压能力优先级和拉伸能力优先级（Compression Resistance and Content Hugging）

关于这个名词，翻译比较困难，这里采用了意译。Compression Resistance直接翻译为压缩阻力，Content Hugging直接翻译为内容抱紧（吸附），系统采用优先级（priority）设定方式使用这两个参数，控制多个控件视图在父视图尺寸布局或者变化时，控件视图倾向于更改自己的大小还是更倾向于保持自己的固有大小（内容期望尺寸Intrinsic Content Size）。这个优先级范围为1~1000，1000为最高优先级，**抗压能力优先级缺省为750，越小越容易被压缩，越大抗压缩能力越强；拉伸能力优先级缺省为250，越小越容易被拉伸，越大抗拉伸能力越强**。

这两个属性是配合内容期望尺寸（Intrinsic Content Size）生效的，通过内容期望尺寸指定抗压和拉伸的坚持目标尺寸。普通的View内容期望尺寸(UIViewNoIntrinsicMetric，UIViewNoIntrinsicMetric)，也就是(-1,-1)，这两个属性是不生效的，需要重载[`intrinsicContentSize`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/intrinsicContentSize) 配合实现。

另外，内容期望尺寸、抗压能力优先级和拉伸能力优先级是两个维度，在Vertical和Horizontal分别设置生效。

在系统处理上，内容期望尺寸、抗压能力优先级和拉伸能力优先级被转换成约束，对于一个内容期望尺寸大小为`{ 100, 30 }`的视图，两个维度的抗压能力优先级缺省为750，拉伸能力优先级缺省为250，如下四个约束被生成：

```swift
H:[label(<=100@250)]
H:[label(>=100@750)]
V:[label(<=30@250)]
V:[label(>=30@750)]
```

约束可视化显示，可以参考[苹果文档](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html)。理解这些约束如何被系统隐含生成并生效会帮助解决布局问题。

说明：上面一节内容参考了[Auto Layout压缩阻力及内容吸附讲解](http://www.cocoachina.com/ios/20160229/15455.html)，并根据内容作了[Swift版本的示例]()。

一下是部分代码例子：

```swift
//设置比缺省值小，则容易被拉伸
//view2.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
//设置比缺省值小，则容易被压缩
//label2.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
```



### 视图框架和对齐矩阵（Frame vs. Alignment Rect）

自动布局不是在视图的框架上操作，而是在视图的对齐矩形上操作。但是，对齐矩形实际上是一个强大的新概念，它将视图的布局对齐边缘与其视觉外观分离开来。

默认情况下alignmentRect与frame是一致的，除非子类重写了alignmentRectInsets方法。alignmentRect不包括视图的阴影等外部装饰部分的空间，因此对齐的时候需要处理。

另外两个相关的重载函数 [`alignmentRectForFrame:`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/alignmentRectForFrame:) 和 [`frameForAlignmentRect:`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/frameForAlignmentRect:)能够更多控制。

（这一部分还不太完全清晰。。。）



### 基线对齐（Baseline Alignment）

这部分不清楚，需要补充信息。



### 控制布局（Taking Control of Layout）

通过定制视图，对视图的子视图subviews追加本地化约束更新，并且在影响变化的时候更新约束，布局就可以传递给子视图。

需要说明的是，显示、布局是top-down，约束更新时bottom-up的。



#### 本地约束（Local Constraints）

UIView的[`requiresConstraintBasedLayout`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/clm/NSView/requiresConstraintBasedLayout) 控制使用约束方式进行布局，目前已经强制为true。

在UIView的 [`updateConstraints`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/updateConstraints)中实现自定义的本地约束，并保证在最后调用父类的 [`updateConstraints`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/updateConstraints)。

在这个步骤中，你不能无效（invalidate）任何约束，因为这一步是由layout process发起的，系统会报告程序错误。（这句话有点问题，待考究。）

如果一些约束需要更改（invalidate），你应该在需要的地方，例如按钮的响应事件中，尽快删除对应的约束，并且调用 [`setNeedsUpdateConstraints`](http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/instm/UIView/setNeedsUpdateConstraints)。（参考最佳实践章节的思路，这个作为第三方建议，不作为最佳实践采用。）



#### 控制子视图的布局（Control Layout of Subviews）

如果你不用约束进行布局控制，你可以使用iOSde [`layoutSubviews`](http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/instm/UIView/layoutSubviews) 或OS X的 [`layout`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/layout)方法进行布局控制。

完全丢弃约束布局，你可以在重载方法中不调用父类的方法，这样根据计算，任意放置所有的子视图。

如果你还需要使用约束布局功能，你必须先调用父类的重载方法，然后细调布局内容。您可以使用它来创建无法使用约束定义的布局，例如涉及视图之间的大小和间距关系的布局。

另一个有趣的用例是创建布局依赖的视图树。自动布局完成第一次遍历并设置自定义视图子视图上的框架尺寸后，您可以检查这些子视图的定位和大小，并对视图层次结构和/或约束进行更改。WWDC教程 [228 – Best Practices for Mastering Auto Layout](https://developer.apple.com/videos/wwdc/2012/?id=228) 中有一个好的例子，当子视图被裁剪的情况发生，则直接移出子视图。

您还可以决定在第一次布局传递之后更改约束。例如，如果视图变得太窄，则从将子视图排成一行切换到两行。

```
- layoutSubviews
{
    [super layoutSubviews];
    if (self.subviews[0].frame.size.width <= MINIMUM_WIDTH) {
        [self removeSubviewConstraints];
        self.layoutRows += 1;
        [super layoutSubviews];
    }
}

- updateConstraints
{
    // add constraints depended on self.layoutRows...
    [super updateConstraints];
}
```

## 内容期望尺寸和多行文本（Intrinsic Content Size of Multi-Line Text）

 `UILabel` 和 `NSTextField` 的内容期望尺寸特别对于多行，高度依赖宽度和文本的内容数量。而宽度在约束解决之前还没有确定，为了解决这个问题，这两个控件追加了一个 [`preferredMaxLayoutWidth`](http://developer.apple.com/library/ios/documentation/uikit/reference/UILabel_Class/Reference/UILabel.html#//apple_ref/occ/instp/UILabel/preferredMaxLayoutWidth)属性用于计算最大行宽。（这一章节的内容在最新的Swift4.2版本下面，已经不需要这么麻烦了，请参见 [Table图片+多行文字](./AutolayoutAndPurelayout/IntrinsicContentSize/CodeTableViewController.swift) 示例的实现。）

我们通常不知道这个值是多少，这个时候需要两步处理，第一遍根据约束计算出Label的frame大小，然后设定preferredMaxLayoutWidth，然后重新再计算一遍约束，来得到正确的高度。

```
- (void)layoutSubviews
{
    [super layoutSubviews];
    myLabel.preferredMaxLayoutWidth = myLabel.frame.size.width;
    [super layoutSubviews];
}
```

第一遍是为了计算Label的frame大小，第二遍是必须的，因为修改了preferredMaxLayoutWidth如果不及时再次计算，系统会报告`NSInternalInconsistencyException` 异常，必须立即更新约束。

如果有Label的子类实现，也可以放在子类中实现。

```
@implementation MyLabel
- (void)layoutSubviews
{
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutSubviews];
}
@end
```

这时候，不需要两次调用super的layoutSubviews，因为当前layoutSubviews被调用的时候，父类的layoutSubviews已经被调用过了，我们已经知道了frame的尺寸。

在UIViewController中，需要在`viewDidLayoutSubviews`进行处理。

```
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    myLabel.preferredMaxLayoutWidth = myLabel.frame.size.width;
    [self.view layoutIfNeeded];
}
```

最后，不要有高优先级的显示Label的高度约束，否则会忽略内容计算出来的高度。

## 动画（Animation）

动画根据约束的控制实现方式不同，请参照示例：

- [Table图片+多行文字](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/IntrinsicContentSize/CodeTableViewController.swift)
- [7.Animating Constraints](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample7ViewController.swift)
- [10.Constraints Without Installing](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample10ViewController.swift)
- [12.Basic Auto Layout with Constraint toggle](https://github.com/dragonetail/AutolayoutAndPurelayout/blob/master/AutolayoutAndPurelayout/PurelayoutBasic/PurelayoutExample12ViewController.swift)



## 关于UIViewController的启动过程

UIViewController的启动过程，如下可以被重载定制的方法和行为的调用顺序：

```swift
0、loadView()    # 构建View图层，追加subviews元素，设置controller基础信息例如title，设置controller的view属性
-->
1、viewDidLoad()
-->
2、viewWillAppear()  #显示处理过程会自动调用layout的处理（4、5），但是layout处理不会自动调用约束更新，需要在Controller的视图上调用view.setNeedsUpdateConstraints()触发约束更新。通常应该在viewDidLoad()方法中加载
-->
3、updateViewConstraints()  # 需要View调用setNeedsUpdateConstraints()进行触发，当一个View有一个ViewController，这个消息被发送给Controller的updateViewConstraints()，而不是视图的updateConstraints()。重载方法应该调用父类的方法或者直接调用视图的updateViewConstraints()。
-->
4、viewWillLayoutSubviews()
-->
5、viewDidLayoutSubviews()
-->
6、viewDidAppear()
```

下面是UIViewController.updateViewConstraints()的帮助。

```
Note
It is almost always cleaner and easier to update a constraint immediately after the affecting change has occurred. For example, if you want to change a constraint in response to a button tap, make that change directly in the button’s action method.
建议在影响更新的地方直接更改约束更新，这样会更简单和清晰。如何处理之前的约束？
You should only override this method when changing constraints in place is too slow, or when a view is producing a number of redundant changes.
只有当很多约束需要更新，或更新太慢时才需要重载这个方法。
To schedule a change, call setNeedsUpdateConstraints() on the view. The system then calls your implementation of updateViewConstraints() before the layout occurs. This lets you verify that all necessary constraints for your content are in place at a time when your properties are not changing.
Your implementation must be as efficient as possible. Do not deactivate all your constraints, then reactivate the ones you need. Instead, your app must have some way of tracking your constraints, and validating them during each update pass. Only change items that need to be changed. During each update pass, you must ensure that you have the appropriate constraints for the app’s current state.
约束更新必须高效，你需要有机制跟踪变化的约束进行针对更新，不应该出现先禁用所有的约束然后再追加约束的操作手法。
Do not call setNeedsUpdateConstraints() inside your implementation. Calling setNeedsUpdateConstraints() schedules another update pass, creating a feedback loop.
不要在重载方法内部再调用setNeedsUpdateConstraints()，会死循环的。
Important
Call [super updateViewConstraints] as the final step in your implementation.
在重新方法的最后，要调用父类的updateViewConstraints()方法（实质会调用View的updateConstraints（）方法）。
```



### translatesAutoresizingMaskIntoConstraints的作用

参考： https://www.jianshu.com/p/d67395deb694

- 把 autoresizingMask 转换为 Constraints
- 即：可以把 frame ，bouds，center 方式布局的视图自动转化为约束形式。（此时该视图上约束已经足够 不需要手动去添加别的约束）

### 为什么 translatesAutoresizingMaskIntoConstraints 使用约束布局时候，就要设置为 NO？

translatesAutoresizingMaskIntoConstraints 的本意是将 frame 布局 自动转化为 约束布局，转化的结果是为这个视图自动添加所有需要的约束，如果我们这时给视图添加自己创建的约束就一定会约束冲突。

为了避免上面说的约束冲突，我们在代码创建 约束布局 的控件时 直接指定这个视图不能用frame 布局（即translatesAutoresizingMaskIntoConstraints=NO），可以放心的去使用约束了。

### 关于是否使用UpdateViewConstraints的讨论：

https://github.com/PureLayout/PureLayout/issues/159

https://github.com/PureLayout/PureLayout/issues/143

还有几篇也不错的文章，忘了参考地址了。





### 参考：UIViewController在Autolayout初始化上的问题辨析：

在Controller中不能对Controller的View实施：

```
     _ = self.view.configureForAutoLayout("Main ViewController")
```

如果追加设置了，则进入Controller后，不能正常获取Frame尺寸，需要在updateViewContrains中追加如下：

```
	self.view.autoPinEdgesToSuperviewSafeArea()
```

追加后Controller看似能够正常工作了。

但是在多次调用测试之后，如下Controller切换过程中Controller的行为变得很奇怪：

```
NavigationController -> main controller -> sub controller
```

**注意问题**多次由Main Controller切换到Sub Controller，并且回退，起初Controller的行为一切正常，多次之后发现Main Controller在从子Controller回退之后会调用updateViewContrians和viewWillLayoutSubviews这些本不会调用的方法，在模拟器中感觉切换Controller的速度也变慢下来了。

在没有更好的方法之前，**不建议对Controller的View实施Autolayout设置，即translatesAutoresizingMaskIntoConstraints的设置还是缺省为True**（使用**AutoresizingMask**模式），这样保障缺省的Controller View能够正常自己管理他的Frame尺寸。但是对于**View还是要在生成的时候使用configureForAutoLayout("Main ViewController")作为最佳实践坚持。**

```
使用AutoresizingMask模式的Controller输出的约束：
<NSLayoutConstraint:0x600001beada0 V:|-(0)-[tableView]   (active, names: tableView:0x7fb7bb86bc00, '|':UIView:0x7fb7bb413950 )>
<NSLayoutConstraint:0x600001beadf0 H:|-(0)-[tableView]   (active, names: tableView:0x7fb7bb86bc00, '|':UIView:0x7fb7bb413950 )>
<NSLayoutConstraint:0x600001beae40 tableView.bottom == UIView:0x7fb7bb413950.bottom   (active, names: tableView:0x7fb7bb86bc00 )>
<NSLayoutConstraint:0x600001beae90 tableView.trailing == UIView:0x7fb7bb413950.trailing   (active, names: tableView:0x7fb7bb86bc00 )>
<NSLayoutConstraint:0x600001beaf30 'UIView-Encapsulated-Layout-Height' UIView:0x7fb7bb413950.height == 736   (active)>
<NSAutoresizingMaskLayoutConstraint:0x600001beafd0 h=-&- v=-&- 'UIView-Encapsulated-Layout-Left' UIView:0x7fb7bb413950.minX == 0   (active, names: '|':UIViewControllerWrapperView:0x7fb7bb424440 )>
<NSAutoresizingMaskLayoutConstraint:0x600001beb020 h=-&- v=-&- 'UIView-Encapsulated-Layout-Top' UIView:0x7fb7bb413950.minY == 0   (active, names: '|':UIViewControllerWrapperView:0x7fb7bb424440 )>
<NSLayoutConstraint:0x600001beaf80 'UIView-Encapsulated-Layout-Width' UIView:0x7fb7bb413950.width == 414   (active)>

使用translatesAutoresizingMaskIntoConstraints为false和self.view.autoPinEdgesToSuperviewSafeArea()模式的Controller输出的约束：
<NSLayoutConstraint:0x60000252cc80 V:|-(0)-[tableView]   (active, names: tableView:0x7fa05e050000, main:0x7fa05ed0cb20, '|':main:0x7fa05ed0cb20 )>
<NSLayoutConstraint:0x60000252ccd0 H:|-(0)-[tableView]   (active, names: tableView:0x7fa05e050000, main:0x7fa05ed0cb20, '|':main:0x7fa05ed0cb20 )>
<NSLayoutConstraint:0x60000252cd20 tableView.bottom == main.bottom   (active, names: tableView:0x7fa05e050000, main:0x7fa05ed0cb20 )>
<NSLayoutConstraint:0x60000252cd70 tableView.trailing == main.trailing   (active, names: tableView:0x7fa05e050000, main:0x7fa05ed0cb20 )>
```

在translatesAutoresizingMaskIntoConstraints为false时self.view.autoPinEdgesToSuperviewSafeArea()执行不执行的区别是画面是否能够正常显示，但是对应Controller的View的约束没有变化，**这个非常奇怪**。

【补充】大概明白了问题出现在什么地方了，self.view.autoPinEdgesToSuperviewSafeArea()是对当前的View进行约束，约束的关系是当前View与其superView之间，形成的约束关系出现了在superView的constraints属性上了，在使用了NavigationController之类的控制器调度后，多个Controller迁移显示的上层superView都是共通的上层Controller的Wrapper，因此做多个Controller中使用translatesAutoresizingMaskIntoConstraints为false时self.view.autoPinEdgesToSuperviewSafeArea()就会对这个上层Controller的Wrapper的View的约束进行混乱。

**【结论再次强调】**作为最佳实践，在Controller及其View，不要试图使用Autolayout对齐直接视图进行管理，老老实实让AutoresizingMask在Controller的View上生成对应Frame尺寸的约束，对Controller的下层View再使用Autolayout模式，即对Controller的subviews都可以使用Autolayout模式，但是对Controller不要使用。





------

## 小技巧

### UIStackView使用Autolaylout的时候不行看设置上下边界

例如，如下代码会出现冲突

```
//addButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)//追加到StackView中的内容不需要设置上下边界
```



### 执行一次的代码实现

例如，如下代码会出现冲突

```
public extension DispatchQueue {
    private static var _onceTracker = [String]()

    public class func once(file: String = #file, function: String = #function, line: Int = #line, block: () -> Void) {
        let token = file + ":" + function + ":" + String(line)
        once(token: token, block: block)
    }

    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }


        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
```





------

## 其他，待补充

### 


##### Handling View Rotations

As of iOS 8, all rotation-related methods are deprecated. Instead, rotations are treated as a change in the size of the view controller’s view and are therefore reported using the [`viewWillTransition(to:with:)`](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition) method. When the interface orientation changes, UIKit calls this method on the window’s root view controller. That view controller then notifies its child view controllers, propagating the message throughout the view controller hierarchy.

In iOS 6 and iOS 7, your app supports the interface orientations defined in your app’s `Info.plist` file. A view controller can override the [`supportedInterfaceOrientations`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations)method to limit the list of supported orientations. Typically, the system calls this method only on the root view controller of the window or a view controller presented to fill the entire screen; child view controllers use the portion of the window provided for them by their parent view controller and no longer participate directly in decisions about what rotations are supported. The intersection of the app's orientation mask and the view controller's orientation mask is used to determine which orientations a view controller can be rotated into.

You can override the [`preferredInterfaceOrientationForPresentation`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor) for a view controller that is intended to be presented full screen in a specific orientation.

When a rotation occurs for a visible view controller, the [`willRotate(to:duration:)`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621376-willrotate), [`willAnimateRotation(to:duration:)`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621458-willanimaterotation), and [`didRotate(from:)`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621492-didrotate) methods are called during the rotation. The [`viewWillLayoutSubviews()`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews) method is also called after the view is resized and positioned by its parent. If a view controller is not visible when an orientation change occurs, then the rotation methods are never called. However, the [`viewWillLayoutSubviews()`](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews) method is called when the view becomes visible. Your implementation of this method can call the [`statusBarOrientation`](https://developer.apple.com/documentation/uikit/uiapplication/1623026-statusbarorientation) method to determine the device orientation.

NoteAt launch time, apps should always set up their interface in a portrait orientation. After the [`application(_:didFinishLaunchingWithOptions:)`](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) method returns, the app uses the view controller rotation mechanism described above to rotate the views to the appropriate orientation prior to showing the window.



## 参考

- https://github.com/PureLayout/PureLayout/wiki/Tips-and-Tricks
- https://www.objc.io/issues/3-views/advanced-auto-layout-toolbox/
- https://www.jianshu.com/p/3a872a0bfe11
- http://www.cocoachina.com/ios/20160229/15455.html
- https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1



