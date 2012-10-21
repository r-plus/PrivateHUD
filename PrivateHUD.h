#import <UIKit/UIKit.h>

@interface PrivateHUD : UIWindow

// If you manually change to done or dissmiss, doneDelay:-1 autoHideDelay:-1
+ (void)showWithHUDSize:(CGSize)HUDSize;
+ (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text;
+ (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text doneDelay:(NSTimeInterval)doneDelay autoHideDelay:(NSTimeInterval)autoHideDelay;
// Manually change to done check mark.
+ (void)done;
// Manually dismiss.
+ (void)dismiss;

@end
