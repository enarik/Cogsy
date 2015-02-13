//
//  OwnedRecordItem.h
//  Cogsy
//
//  Created by Tyler Kirane on 2/12/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnedRecordItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
