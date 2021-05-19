// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

#import <ASTemplateConfiguration/ASTemplateConfiguration-Swift.h>
#import "HLAlertsFabric.h"

@implementation HLAlertsFabric

+ (UIAlertController *)showAlertWithText:(NSString *)text title:(NSString *)title inController:(UIViewController *)parentController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:text
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:TemplateAppLocalizations.shared.alertOkButtonTitle style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [parentController presentViewController:alertController animated:YES completion:nil];

    return alertController;
}

+ (void)showMailSenderUnavailableAlertInController:(UIViewController *)controller
{
    [self showAlertWithText:TemplateAppLocalizations.shared.emailUnavailableMessage
                      title:TemplateAppLocalizations.shared.emailUnavailableTitle
               inController:controller];
}

@end
