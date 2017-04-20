//
//  BaseVariable.h
//  SFS2X
//
//  Created by Lapo on 26/10/16.
//  Copyright © 2016 A51 Integrated | http://a51integrated.com. All rights reserved.
//

#import "Variable.h"
#

@interface BaseVariable : NSObject <Variable>
{

@protected
    NSString* _name;
    NSString* _type;
    id _value;
}

/** The Variable name */
@property (nonatomic, readonly) NSString *name;

/** The Variable Type
 
 @see VariableType
 */
@property (nonatomic, readonly) NSString *type;

-(id)initWithName:(NSString *)name value:(id)value type:(NSInteger)type;

/**
 @param name the name of the variable
 @param value the variable value ( can be BOOL, Integer, Double, String, SFSObject, SFSArray )
 @param type (optional -1) it's usually not necessary to pass this parameter as the variable value is auto-detected
 */
+(id)variableWithName:(NSString *)name value:(id)value type:(NSInteger)type;
+(id)variableWithName:(NSString *)name value:(id)value;

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

/**  The Variable value as SFSObject
 
 @see SFSObject
 */
-(id <ISFSObject>)getSFSObjectValue;

/**
 The Variable value as SFSArray
 */
-(id <ISFSArray>)getSFSArrayValue;

/** Checks if the variable value is null */
-(BOOL)isNull;

-(id<ISFSArray>)toSFSArray;

@end
