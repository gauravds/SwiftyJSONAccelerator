//
//  RKMarkdownParser.h
//  RKMarkdownParser
//
//  Created by Punchh on 10/17/16.
//  Copyright © 2016 Punchh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKMarkdownParser : NSObject

@property (nonatomic, strong) NSMutableDictionary *outputDictionary;

- (instancetype)initWithString:(NSString *)string;
- (NSString *)textForKey:(NSString *)key;

@end
