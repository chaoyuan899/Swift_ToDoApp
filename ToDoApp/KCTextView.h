//
//  KCTextView.h
//  memberapp
//
//  Created by Johnny on 14-5-3.
//  Copyright (c) 2014年 com.by-health. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCTextView : UITextView

/**
 The string that is displayed when there is no other text in the text view.
 
 The default value is `nil`.
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 The color of the placeholder.
 
 The default is `[UIColor lightGrayColor]`.
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;


@end
