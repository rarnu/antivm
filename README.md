# AntiVm

Android 端环境检测库，可以检测当前的设备是否被 Root，是否有 Xposed 等勾子程序，当前 App 是否运行在模拟器，是否被双开。

打算在后续加入更多检测项。

- - -

### 使用方法

```
compile 'com.github.rarnu:antivm:1.0.0'
```

在你的项目中只需要访问以下方法即可：

```
AntiVM.init()       // 在程序启动时执行初始化
AntiVM.isEmulator() // 是否运行在模拟器内
AntiVM.isRooted()   // 设备是否被 Root
AntiVM.isHooked()   // 设备是否被 Hook
AntiVM.isInVM()     // 是否运行于虚拟机环境（双开，分身等）
```

### 编译 NDK 代码

如果需要自行修改并编译 NDK 部分代码，请先参考 [fpccmd](https://github.com/rarnu/fpccmd) 项目，并编译其可执行程序。

执行以下命令以完成编译:

```
$ fpccmd AA antivm.ppr          # 编译 ARM 架构的库
$ fpccmd AI antivm.ppr          # 编译 x86 架构的库
```

