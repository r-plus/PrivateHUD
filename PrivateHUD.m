#import <QuartzCore/QuartzCore.h>
#import "PrivateHUD.h"

@interface UIProgressHUD : UIView
- (void)showInView:(UIView *)view;
- (void)hide;
- (void)done;
- (void)setText:(NSString *)text;
@end

@interface PrivateHUD (Private)
- (void)startWithHUDSize:(CGSize)HUDSize text:(NSString *)text doneDelay:(NSTimeInterval)doneDelay autoHideDelay:(NSTimeInterval)autoHideDelay;
@end

@implementation PrivateHUD

static PrivateHUD *sharedHUD;
static UIProgressHUD *progressHUD;

+ (void)showWithHUDSize:(CGSize)HUDSize
{
    [PrivateHUD showWithHUDSize:HUDSize text:nil];
}

+ (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text
{
    [PrivateHUD showWithHUDSize:HUDSize text:text doneDelay:-1 autoHideDelay:-1];
}

+ (void)showWithHUDSize:(CGSize)HUDSize text:(NSString *)text doneDelay:(NSTimeInterval)doneDelay autoHideDelay:(NSTimeInterval)autoHideDelay
{
    CGFloat angle;
    switch ([UIApplication sharedApplication].keyWindow.rootViewController.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            angle = M_PI * 0;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI * 1;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = M_PI * -0.5;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI * 0.5;
            break;
    }
    if (!sharedHUD) {
        sharedHUD = [[PrivateHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sharedHUD.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        sharedHUD.windowLevel = UIWindowLevelAlert;
    }
    sharedHUD.transform = CGAffineTransformMakeRotation(angle);
    sharedHUD.hidden = NO;
    [sharedHUD startWithHUDSize:HUDSize text:text doneDelay:doneDelay autoHideDelay:autoHideDelay];
}

+ (void)dismiss
{
    if (sharedHUD && progressHUD) {
        [UIView animateWithDuration:0.15 animations:^ {
            progressHUD.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 0.7, 0.7, 1);
            progressHUD.layer.opacity = 0.0;
        } completion:^(BOOL finished) {
            [progressHUD hide];
            sharedHUD.hidden = YES;
            [sharedHUD release];
            [progressHUD release];
            sharedHUD = nil;
            progressHUD = nil;
        }];
    }
}

+ (void)done
{
    [progressHUD done];
}

- (void)startWithHUDSize:(CGSize)HUDSize text:(NSString *)text doneDelay:(NSTimeInterval)doneDelay autoHideDelay:(NSTimeInterval)autoHideDelay
{
    CGFloat originX = self.bounds.origin.x + (self.bounds.size.width - HUDSize.width) / 2;
    CGFloat originY = self.bounds.origin.y + (self.bounds.size.height - HUDSize.height) / 2;
    progressHUD = [[UIProgressHUD alloc] initWithFrame:CGRectMake(originX, originY, HUDSize.width, HUDSize.height)];
    progressHUD.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    if (doneDelay >= 0.0f)
        [PrivateHUD performSelector:@selector(done) withObject:nil afterDelay:doneDelay];
    [progressHUD setText:text];
    progressHUD.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1.3, 1.3, 1);
    progressHUD.layer.opacity = 0.3;
    [UIView animateWithDuration:0.15 animations:^ {
        [progressHUD showInView:self];
        progressHUD.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1, 1, 1);
        progressHUD.layer.opacity = 1.0;
    } completion:^(BOOL finished) {
        if (autoHideDelay >= 0.0f)
            [PrivateHUD performSelector:@selector(dismiss) withObject:nil afterDelay:autoHideDelay];
    }];
}

@end

/* vim: set ts=4 sw=4 sts=4 expandtab: */ 
