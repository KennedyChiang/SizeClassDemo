# SizeClassDemo
參考 [raywenderlich： adaptive-layout-tutorial-ios-11-getting-started](https://www.raywenderlich.com/162311/adaptive-layout-tutorial-ios-11-getting-started) 教學，但完全使用程式碼實現。 

### 實作方式
新增三個 Constrains 實作及適當時機切換
  * sharedConstraints
  * regularConstraints
  * compactConstraints
  
### 注意事項
`- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection` 
第一次 `horizontalSizeClass`、`verticalSizeClass` 會取得 `UIUserInterfaceSizeClassUnspecified`，這部分需要另外判斷；
這邊直接透過 `[UIScreen mainScreen].bounds` 去判斷長寬比去決定實作的 `Constraints`。

`self.traitCollection` 跟 `previousTraitCollection` 相反

為什麼不用 `Visual Format Language`?
主要是因為再 `xcode 9`, `iOS 11` 有點問題，參考資訊如下：
https://stackoverflow.com/questions/46576358/uiscrollview-not-scrolling-in-ios11


### 參考資料
> ## Default Size Classes for Different Devices

>Each iOS device has a default set of size classes that you can use as a guide when designing your interface. Table 12-2 lists the size classes for devices in both portrait and landscape orientations. Devices not listed in the table have the same size classes as the device with the same screen dimensions.
>
>**Table 12-2** Size classes for devices with different screen sizes.
>
>| Device                                   | Portrait                                 | Landscape                                |
>| ---------------------------------------- | :--------------------------------------- | ---------------------------------------- |
>| iPad (all)<br />iPad Mini                | Vertical size class: Regular <br />Horizontal size class: Regular | Vertical size class: Regular <br />Horizontal size class: Regular |
>| iPhone 6 Plus                            | Vertical size class: Regular <br />Horizontal size class: Compact | Vertical size class: Compact <br />Horizontal size class: Regular |
>| iPhone 6                                 | Vertical size class: Regular <br />Horizontal size class: Compact | Vertical size class: Compact <br />Horizontal size class: Compact |
>| iPhone 5s <br />iPhone 5c<br /> iPhone 5 | Vertical size class: Regular<br /> Horizontal size class: Compact | Vertical size class: Compact <br />Horizontal size class: Compact |
>| iPhone 4s                                | Vertical size class: Regular<br /> Horizontal size class: Compact | Vertical size class: Compact <br />Horizontal size class: Compact |
>
>
>>IMPORTANT
>>
>>Never assume that your app will be displayed with a specific size class on a device. Always check the size class found in an object’s trait collection when making decisions about how to configure that object.

### 參考連結
[Apple Official Document](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/TheAdaptiveModel.html#//apple_ref/doc/uid/TP40007457-CH19-SW4)
