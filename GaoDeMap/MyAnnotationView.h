//
//  MyAnnotationView.h
//  GaoDeMap
//
//  Created by mac on 16/8/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView<MKAnnotation>
{
    UILabel *label;
}

- (void)setClusterText:(NSString *)text;

@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;



@end
