//
//  TagsTextViewDelegate.h
//  CashControl
//
//  Created by Mandea Daniel on 26/06/15.
//  Copyright (c) 2015 MindMagnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagsTextViewDelegate <NSObject>

/**
 *  This method will be called when text view changes
 *
 *  @param text The text contained by the text view
 */
- (void)tagsTextViewUpdatedText:(NSString * __nullable)text;

/**
 *  This method gets called when tags array changes
 *
 *  @param tags The new tags array
 */
- (void)tagsTextViewUpdatedTags:(NSArray * __nullable)tags;

@end
