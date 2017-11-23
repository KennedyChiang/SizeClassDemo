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
