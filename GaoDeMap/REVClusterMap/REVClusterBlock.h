//
//  REVClusterBlock.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "REVAnnotationsCollection.h"


@interface REVClusterBlock : NSObject
{
    REVAnnotationsCollection *annotationsCollection;
    
    MKMapRect blockRect;
}

@property MKMapRect blockRect;

- (void) addAnnotation:(id<MKAnnotation>)annotation;
- (id<MKAnnotation>) getClusteredAnnotation;
- (id<MKAnnotation>) getAnnotationForIndex:(NSInteger)index;
- (NSInteger) count;


@end
