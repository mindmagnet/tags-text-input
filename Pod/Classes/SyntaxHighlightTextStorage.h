//
//  SyntaxHighlightTextStorage.h
//  TestTagTextView
//
//  Created by Mandea Daniel on 25/06/15.
//  Copyright (c) 2015 Mandea Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyntaxHighlightTextStorage : NSTextStorage

/**
 *  @brief Use this method in order to set the replacements for the retrived
 *  This NSDictionary should contain keys and values like the following:
 *  ex: @"(\\#\\w+)*\\s" :  @{ NSForegroundColorAttributeName : [UIColor whiteColor]},
 *  This exapmle detects strings that start with # and end with an empty space
 */
@property (nonatomic, strong, readwrite, nonnull) NSDictionary *replacements;

/**
 *  Use this method in order to set normal text attributes 
 */
@property (nonatomic, strong, readwrite, nonnull) NSDictionary *textAttributes;

@end

