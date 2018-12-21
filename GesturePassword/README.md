# GesturePassword 是一个Swift的手势密码库
* 采用底层CALayer实现
* 业务逻辑和UI分离，可以高度定制
* 支持中英文
* 采用UserDefaults和Keychain两套密码缓存机制

# Cocoapods

```ruby
pod 'GesturePassword'
```



### 1.设置密码


![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/setting.gif)

>

### 2.验证密码

![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Verify.gif)


>


### 3.修改密码

![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Modify.gif)


>


# Usage
1. 将Lock.swift文件拖入你的工程
2. 使用二次封装的AppLock类自己调用**设置密码**、**修改密码**、**验证密码**
```swift
let AppLock = Lock.shared

class Lock {

    static let shared = Lock()

    private init() {
        // 在这里自定义你的UI
        LockCenter.passwordKeySuffix = "user1"

//        LockCenter.usingKeychain = true
//        LockCenter.lineWidth = 2
//        LockCenter.lineWarnColor = .blue
    }

    func set(controller: UIViewController) {
        if hasPassword {
            print("密码已设置")
            print("🍀🍀🍀 \(password) 🍀🍀🍀")
        } else {
            showSetPattern(in: controller).successHandle = {
                LockCenter.set($0)
            }
        }
    }

    func verify(controller: UIViewController) {
        guard hasPassword else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
            return
        }

        print("密码已设置")
        print("🍀🍀🍀 \(password) 🍀🍀🍀")
        showVerifyPattern(in: controller).successHandle {
            $0.dismiss()
        }.overTimesHandle {
            LockCenter.removePassword()
            $0.dismiss()
            assertionFailure("你必须做错误超限后的处理")
        }.forgetHandle {
            $0.dismiss()
            assertionFailure("忘记密码，请做相应处理")
        }
    }

    func modify(controller: UIViewController) {
        guard hasPassword else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
            return
        }

        print("密码已设置")
        print("🍀🍀🍀 \(password) 🍀🍀🍀")
        showModifyPattern(in: controller).forgetHandle { _ in

            }.overTimesHandle { _ in

            }.resetSuccessHandle {
                print("🍀🍀🍀 \($0) 🍀🍀🍀")
        }
    }

    var hasPassword: Bool {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        return LockCenter.hasPassword()
    }

    var password: String {
        return LockCenter.password() ?? ""
    }

    func removePassword() {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        LockCenter.removePassword()
    }
}

```

# 版本记录
* [2.0](https://github.com/huangboju/GesturePassword/blob/master/Doc/MigrationGuide2.0.md)
* [1.0](https://github.com/huangboju/GesturePassword/blob/master/Doc/MigrationGuide1.0.md)

