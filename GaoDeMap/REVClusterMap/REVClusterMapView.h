//
//  REVClusterMapView.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface REVClusterMapView : MKMapView<MKMapViewDelegate>{
    
    NSUInteger blocks;
    NSUInteger minimunClusterLevel;
    
    NSArray *annotationsCopy;
    
    double zoomLevel;
}

@property (nonatomic, assign)NSUInteger blocks;
@property (nonatomic, assign)NSUInteger minimumClusterLevel;

@property(nonatomic,assign) id<MKMapViewDelegate> delegate;


@end
