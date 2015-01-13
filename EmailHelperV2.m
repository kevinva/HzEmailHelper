//
//  EmailHelperV2.m
//  21DigitalPaperiPad
//
//  Created by 何 峙 on 13-8-2.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "EmailHelperV2.h"



@interface EmailHelperV2 ()

+ (id)sharedInstance;
- (void)launchMailAppOnDeviceRecipients:(NSArray *)recipients subject:(NSString *)subject content:(NSString *)messageBody;

@end

@implementation EmailHelperV2



#pragma mark - Private methods

+ (id)sharedInstance{
    static EmailHelperV2 *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

- (void)launchMailAppOnDeviceRecipients:(NSArray *)recipients subject:(NSString *)subject content:(NSString *)messageBody{
    NSString *resultRecipientStr;
    if(recipients && recipients.count > 0){
        NSMutableString *recipientStr = [[NSMutableString alloc] init];
        for(NSString *recipient in recipients){
            [recipientStr appendFormat:@"%@,", recipient];
        }
        resultRecipientStr = [recipientStr substringToIndex:recipientStr.length - 1];
        [recipientStr release];        
    }else{
        resultRecipientStr = @"";
    }

	NSString *torecipients = [NSString stringWithFormat:@"mailto:%@&subject=%@", resultRecipientStr, subject];
	NSString *body = [NSString stringWithFormat:@"&body=%@", messageBody];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", torecipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
    
}

#pragma mark - Public methods

+ (void)showEmailViewFromController:(UIViewController *)controller recipients:(NSArray *)recipients subject:(NSString *)subject content:(NSString *)body{
    EmailHelperV2 *helper = [EmailHelperV2 sharedInstance];
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if(mailClass != nil){
        if(![mailClass canSendMail]){
            [helper launchMailAppOnDeviceRecipients:recipients subject:subject content:body];
            return;
        }
    }else{
        [helper launchMailAppOnDeviceRecipients:recipients subject:subject content:body];
        return;
    }
    
    if(!controller){
        return;
    }
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = helper;
    [mailController setSubject:subject];
    [mailController setMessageBody:body isHTML:NO];
    if(recipients && recipients.count > 0){
        [mailController setToRecipients:recipients];
    }
    [controller presentViewController:mailController animated:YES completion:nil];
    [mailController release];
    
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
