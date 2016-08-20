//
//  REVClusterPin.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface REVClusterPin : NSObject <MKAnnotation  >{
    
    CLLocationCoordinate2D coordinate;
    
    NSString *title;
    NSString *subtitle;
    
    NSArray *nodes;
}


@property(nonatomic, retain) NSArray *nodes;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

- (NSUInteger) nodeCount;
@end
