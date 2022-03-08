//
//  Article.h
//  iOS_Challenge
//
//  Created by Hassan, Waseem(eCG) on 07/03/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Article : NSObject

@property(nonatomic, strong) NSString *headline;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
