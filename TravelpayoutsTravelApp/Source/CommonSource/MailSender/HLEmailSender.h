// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "HLMailComposeVC.h"

@interface HLEmailSender : NSObject <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) HLMailComposeVC *mailer;
@property (nonatomic, weak) id<MFMailComposeViewControllerDelegate> delegate;

- (void)sendFeedbackEmailTo:(NSString *)email;

+ (BOOL)canSendEmail;
+ (void)showUnavailableAlertInController:(UIViewController *)controller;
@end
