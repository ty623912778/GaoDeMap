//
//  REVAnnotationsCollection.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface REVAnnotationsCollection : NSObject{
    NSMutableArray *collection;
    
    double xSum;
    double ySum;
}

@property double xSum;
@property double ySum;

@property (nonatomic, readonly)NSMutableArray *collection;
- (void) addObject:(id<MKAnnotation>)annotation;

- (id) objectAtIndex:(NSUInteger)index;
- (NSUInteger) count;


@end
