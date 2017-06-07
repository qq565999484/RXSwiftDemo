
## RxSwift-SwiftyJSON

这是一个把 `Alamofire` 请求的数据 转成 `SwiftyJSON` 中的 `JSON` 或者转化成`对象`


### 安装方法(Installation)

你可以通过`CocoaPods` 来使用`RxSwift-SwiftyJSON` 在你的Podfile中添加如下配置

RxSwift-SwiftyJSON is available through CocoaPods. To install it, simply add the following line to your Podfile:

```
pod 'RxSwift-SwiftyJSON', '~> 1.0.1'
```

然后运行`pod install`


### 使用方法(Usage)

创建一个实现 `ZJSwiftyJSONAble` 协议的`Class` 或者 `Struct`

Create a `Class` or `Struct` which implements the `ZJSwiftyJSONAble` protocol.

如果你返回数据的格式为：

if you get the json like this:

```json
{
    "success":"true",
    "msg":"获取用户信息成功",
    "obj":{
        "userName":"张剑",
        "userAlias":"剑行者",
        "invitationCode":100
    }
}
```

你可以建立以下两个对象：

you can create two model like this:

```swift
import Foundation
import SwiftyJSON

class ZJResult_S<T: ZJSwiftyJSONAble>: ZJSwiftyJSONAble {
    var success: String!
    var msg: String!
    var obj: T?
    
    required init?(jsonData:JSON){
        self.success = jsonData["success"].stringValue
        self.msg = jsonData["msg"].stringValue
        self.obj = T(jsonData: jsonData["obj"])
    }
}
```


```swift
import Foundation
import SwiftyJSON

class ZJUser_S: ZJSwiftyJSONAble {
    var userName: String!
    var userAlias: String!
    var invitationCode: Int!
    
    required init?(jsonData:JSON){
        self.userName = jsonData["userName"].stringValue
        self.userAlias = jsonData["userAlias"].stringValue
        self.invitationCode = jsonData["userAlias"].intValue
    }
}
```

添加pod库

add pod

```
pod 'RxAlamofire'
```

然后我们就可以这样请求数据了

then we can query data like this:

```swift
_ = string(.POST, "http://t.yidaisong.com:90/login!in.do",
    parameters: ["userPhone":"15225178360","userLoginPswd":"123456"])
    .observeOn(MainScheduler.instance)
    .mapSwiftyObject(ZJResult_S<ZJUser_S>)
    .subscribe(
        onNext: { repos -> Void in
            self.showTextView.text = "用SwiftyJSON把结果转为对象\n"
                                   + "用户名：\(repos.obj!.userName)\n"
                                   + "昵称：\(repos.obj!.userAlias)";
        },
        onError: { (error) -> Void in
            self.showTextView.text = "\(error)";
    })
```

是不是很简单

so easy

如果你不想转为对象 想直接用 SwiftyJSON 对应的JSON格式  你可以这样写

if you dont want to change it to model,just to JSON,you can write like this

```swift
_ = string(.POST, "http://t.yidaisong.com:90/login!in.do",
    parameters: ["userPhone":"15225178360","userLoginPswd":"123456"])
    .observeOn(MainScheduler.instance)
    .mapSwiftyJSON()
    .subscribe(
        onNext: { repos -> Void in
            self.showTextView.text = "用SwiftyJSON把结果转为JSON\n"
                                   + "用户名：\(repos["obj"]["userName"].stringValue)\n"
                                   + "昵称：\(repos["obj"]["userAlias"].stringValue)";
        },
        onError: { (error) -> Void in
            self.showTextView.text = "\(error)";
    })
```

### 示例(Demo)

使用方法可以参考下面的示例

Method of use can refer to the following example

[RxAlamofireDemo_Swift](https://github.com/psvmc/RxAlamofireDemo_Swift)


## 作者(Author)

剑行者 

+ 网站: [www.psvmc.cn](http://www.psvmc.cn)
+ 邮箱: [183518918@qq.com](mailto:183518918@qq.com)

## 版权(License)

你可以在MIT许可下使用`RxSwift-SwiftyJSON`，更多信息请查看`LICENSE`文件

`RxSwift-SwiftyJSON` is available under the MIT license. See the LICENSE file for more info.