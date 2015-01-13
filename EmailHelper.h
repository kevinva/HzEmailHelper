//
//  EmailHelper.h
//  Biando
//
//  Created by biando on 13-1-7.
//  Copyright (c) 2013年 biando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface EmailHelper : NSObject<MFMailComposeViewControllerDelegate>

+ (id)sharedInstance;
- (void)showMailComposerFromController:(UIViewController *)controller;

@end
