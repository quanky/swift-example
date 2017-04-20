//
//  SFSUserVariable.h
//  SFS2X
//
//  Original development by Infosfer Game Technologies Ltd. | http://www.infosfer.com.
//
//  Maintained and developed by A51 Integrated.
//  Copyright 2012 A51 Integrated | http://a51integrated.com. All rights reserved.
//

#import "BaseVariable.h"
#import "UserVariable.h"
#import "ISFSArray.h"
#import "ISFSObject.h"

/**The <em>SFSUserVariable</em> object represents a SmartFoxServer User Variable entity on the client.
 It is a custom value attached to a <em>User</em> object that gets automatically synchronized between client and server on every change.
 
 User Variables are particularly useful to store custom user data that must be "visible" to the other users, such as a profile, a score, a status message, etc.
 User Variables can be set by means of the <em>SetUserVariablesRequest</em> request; they support the following data types (also nested):
 <em>Boolean</em>, <em>int</em>, <em>Number</em>, <em>String</em>, <em>SFSObject</em>, <em>SFSArray</em>. A User Variable can also be <code>null</code>.</p>
 
 Private UserVariables are available since SFS2X 2.12 with client API 1.7 and they allow to limit the visibility of variables marked as private to the owner only.
  In other words UserVariables marked as private are not sent to other users in the same Room.</p>
 
 See <User>, <SetUserVariablesRequest>
 
 */

@interface SFSUserVariable : BaseVariable <UserVariable>

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


+(id <UserVariable>)fromSFSArray:(id <ISFSArray>)sfsa;

/**
 * Creates a new private User Variable.
 * Private User Variables are not broadcast to other users: they are only visible on the server side and in the owner's client application.
 *
 * @param 	name	The name of the User Variable
 * @param 	value	The value of the User Variable
 *
 * See <VariableType>
 */
+(id <UserVariable>) privateVariableWithName:(NSString *)name value:(id)value;

/**
 * Indicates whether this User Variable is private or not.
 * A private User Variable is visible only to its owner; any changes made to the variable will be transmitted to the owner only.
 *
 * <p><b>NOTE</b>: setting the <em>private</em> property manually on an existing User Variable returned by the API has no effect on the server and can disrupt the API functioning.
 * This flag can be set when the User Variable object is created by the developer only (using the <em>new</em> keyword).</p>
 */
- (BOOL) isPrivate;

- (void) setPrivate:(BOOL)priv;

-(id<ISFSArray>)toSFSArray;


@end
