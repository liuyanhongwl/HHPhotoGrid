//
//  LDPhotoLibraryFactory.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHPhotoLibrary;

@interface HHPhotoLibraryFactory : NSObject

+ (HHPhotoLibrary *)createPhotoLibrary;


@end
