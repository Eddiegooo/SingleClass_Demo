# SingleClass_Demo
SingleClass basic use


SingleClass的最基本使用。


### 添加了RunLoop 相关知识。使用分类添加属性、方法、拦截替换方法。
Run Time 运行时：
记录一个网站：[Mehtod  Swizzling](http://nshipster.com/method-swizzling/) 

[分类添加属性](http://nszzy.me/2016/01/25/associated-objects/)


```
enum {
        OBJC_ASSOCIATION_ASSIGN = 0,          // 等价于 @property (assign) 或 @property (unsafe_unretained)
        OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,// 等价于 @property (nonatomic, strong)
        OBJC_ASSOCIATION_COPY_NONATOMIC = 3,  // 等价于 @property (nonatomic, copy)
        OBJC_ASSOCIATION_RETAIN = 01401,      // 等价于 @property (atomic, strong)
        OBJC_ASSOCIATION_COPY = 01403         // 等价于 @property (atomic, copy)
};
```


