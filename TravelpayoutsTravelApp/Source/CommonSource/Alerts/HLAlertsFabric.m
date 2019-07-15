// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

#import <JRCommonUtils/JRCommonUtils.h>
#import "HLAlertsFabric.h"

@implementation HLAlertsFabric

+ (UIAlertController *)showAlertWithText:(NSString *)text title:(NSString *)title inController:(UIViewController *)parentController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:text
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLS(@"ALERT_DEFAULT_BUTTON") style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [parentController presentViewController:alertController animated:YES completion:nil];

    return alertController;
}

+ (void)showMailSenderUnavailableAlertInController:(UIViewController *)controller
{
    [self showAlertWithText:NSLS(@"EMAIL_SENDER_UNAVALIBLE_MESSAGE")
                      title:NSLS(@"EMAIL_SENDER_UNAVALIBLE_MESSAGE_TITLE")
               inController:controller];
}

@end
