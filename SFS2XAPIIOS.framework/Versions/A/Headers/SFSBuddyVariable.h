//
//  SFSBuddyVariable.h
//  SFS2X
//
//  Original development by Infosfer Game Technologies Ltd. | http://www.infosfer.com.
//
//  Maintained and developed by A51 Integrated.
//  Copyright 2012 A51 Integrated | http://a51integrated.com. All rights reserved.
//

#import "Common.h"
#import "BuddyVariable.h"
#import "BaseVariable.h"

EXTERN NSString * const SFSBuddyVariable_OFFLINE_PREFIX;
/** BuddyVariables are custom values attached to any Buddy in a BuddyList. They work with the same principle of the User/Room Variables.
 
 The only difference is the logic by which they get propagated to other Users. While RoomVariables are broadcast to all clients in the same Room, BuddyVariables are updated to all Users who have the BuddyVariable owner in their BuddyLists.
  
 BuddyVariables support basic data types and nested complex objects:
 
 - Null
 - Bool
 - Int
 - Double
 - String
 - SFSObject
 - SFSArray
 
 Also there is a special convention that allows certain Variables to be "offline" Buddy Variables. 
 All variable names starting with a dollar sign ($) will set the BuddyVariable as persistent and make them available at any time whether the owner is online or not.
 
 See <SFSBuddy>, <SetBuddyVariablesRequest>, <[ISFSEvents onBuddyVariablesUpdate:]>
 */
@interface SFSBuddyVariable : BaseVariable <BuddyVariable>

/** Return true if this is an offline Buddy Variable
 
 By convention any Buddy Variable whose name starts with the dollar sign ($)
 will be regarded as persistent and stored locally by the server.
 
 These variables are also referred to as "offline variables" because they are available
 to other Users even when the Buddy is offline.
 */
@property (readonly) BOOL isOffline;

/**
 @param name the name of the variable
 @param value the variable value ( can be BOOL, Integer, Double, String, SFSObject, SFSArray )
 @param type (optional -1) it's usually not necessary to pass this parameter as the variable value is auto-detected
 */
+(id)variableWithName:(NSString *)name value:(id)value type:(NSInteger)type;

/**
 @param name the name of the variable
 @param value the variable value ( can be BOOL, Integer, Double, String, SFSObject, SFSArray )
 */
+(id)variableWithName:(NSString *)name value:(id)value;


+(id<BuddyVariable>)fromSFSArray:(id <ISFSArray>)sfsa;


@end
