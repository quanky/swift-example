//
//  Variable.h
//  SFS2X
//
//  Created by Lapo on 26/10/16.
//  Copyright © 2016 A51 Integrated | http://a51integrated.com. All rights reserved.
//

@protocol ISFSArray;
@protocol ISFSObject;

@protocol Variable <NSObject>

/** The Variable name */
-(NSString *)name;

/** The Variable Type
 
 @see VariableType
 */
-(NSString *)type;

/** The Variable value */
-(id)getValue;

/** The Variable value as BOOL */
-(BOOL)getBoolValue;

/** The Variable value as NSInteger */
-(NSInteger)getIntValue;

/** The Variable value as Number */
-(NSNumber *)getDoubleValue;

/** The Variable value as NSString */
-(NSString *)getStringValue;

/** The Variable value as SFSObject
 
 @see SFSObject
 */
-(id <ISFSObject>)getSFSObjectValue;

/** The Variable value as SFSArray */
-(id <ISFSArray>)getSFSArrayValue;

/** Checks if the variable value is null */
-(BOOL)isNull;

-(id<ISFSArray>)toSFSArray;

@end