//
//  TagsTextView.h
//  TestTagTextView
//
//  Created by Mandea Daniel on 25/06/15.
//  Copyright (c) 2015 Mandea Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsTextViewDelegate.h"

@interface TagsTextView : UIView

/**
 * Exposed text view in case we need some custom updates 
 */
@property (nonatomic, strong, nonnull) UITextView *textView;

#pragma mark - Setters

/**
 *  @brief Use this method in order to set the replacements for the retrived
 *  This NSDictionary should contain keys and values like the following:
 *  ex: @"(\\#\\w+)*\\s" :  @{ NSForegroundColorAttributeName : [UIColor whiteColor]},
 *  This exapmle detects strings that start with # and end with an empty space
 */
@property (nonatomic, strong, readwrite, nonnull) NSDictionary *replacements;

/**
 *  @brief Use this method in order to set the tags marker
 *  @discussion By default the tags marger is #
 */
@property (nonatomic, strong, readwrite, nonnull) NSString *tagsMarker;

/**
 *  Use this property in order to set a placeholder text 
 */
@property (nonatomic, strong, readwrite, nonnull) NSString *placeholderText;

/**
 *  Use this property in order to set placeholder default text attributes 
 */
@property (nonatomic, strong, readwrite, nonnull) NSDictionary *placeholderDefaultAttributes;

/**
 *  Use this method in order to set the default text
 */
@property (nonatomic, strong, readwrite, nullable) NSString *text;

/**
 *  Use this method in order to set default text attributes 
 */
@property (nonatomic, strong, readwrite, nonnull) NSDictionary *textDefaultAttributes;

#pragma mark - Added Text

/**
 *  Use this method in order to get added tags
 */
@property (nonatomic, strong, readonly, nullable) NSArray *tagsAdded;

/**
 *  Use this method in order to get the text added (it contanis the tags too)
 */
@property (nonatomic, strong, readonly, nullable) NSString *textAdded;

#pragma mark - Delegate 

/**
 *  Use delegate in order to assign to text view updates 
 */
@property (nonatomic, weak, nullable) id <TagsTextViewDelegate> delegate;

@end
