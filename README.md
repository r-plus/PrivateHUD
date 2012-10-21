## PrivateHUD
Easy and simple HUD system for iOS 4+ using UIProgressHUD(PrivateAPI!).

### Install for theos
* Copy `PrivateHUD.h/.m` file to your project.
* Add `Private.m` to Makefile target file.
* Add `QuartzCore` and `CoreGraphics` to linking FRAMEWORKS list in Makefile.
* Add `#import "PrivateHUD.h"` to your tweak file.

### Usage
Show HUD via class method. If you want to manually manage done or hide timing, should specific 1st or 2nd method in below.
    + (void)showWithHUDSize:(CGSize)HUDSize;
    + (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text;
    + (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text doneDelay:(NSTimeInterval)doneDelay autoHideDelay:(NSTimeInterval)autoHideDelay;
Manually change to done check mark.
    + (void)done;
Manually dismiss.
    + (void)dismiss;

### License
See LICENCE file.([MIT License](http://opensource.org/licenses/mit-license.php))
