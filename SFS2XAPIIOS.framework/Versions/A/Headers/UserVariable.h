//
//  UserVariable.h
//  SFS2X
//
//  Original development by Infosfer Game Technologies Ltd. | http://www.infosfer.com.
//
//  Maintained and developed by A51 Integrated.
//  Copyright 2012 A51 Integrated | http://a51integrated.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Variable;


/**
 See <SFSUserVariable>
 */
@protocol UserVariable <Variable>

- (BOOL) isPrivate;
- (void) setPrivate:(BOOL)priv;

@end
