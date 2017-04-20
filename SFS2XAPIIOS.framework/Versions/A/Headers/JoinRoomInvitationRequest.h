//
//  JoinRoomInvitationRequest.h
//  SFS2X
//
//  Created by Lapo on 25/10/16.
//  Copyright © 2016 A51 Integrated | http://a51integrated.com. All rights reserved.
//

#import "BaseRequest.h"
#import "Room.h"

EXTERN NSString * const JoinRoomInvitationRequest_KEY_ROOM_ID;
EXTERN NSString * const JoinRoomInvitationRequest_KEY_EXPIRY_SECONDS;
EXTERN NSString * const JoinRoomInvitationRequest_KEY_INVITED_NAMES;
EXTERN NSString * const JoinRoomInvitationRequest_KEY_AS_SPECT;
EXTERN NSString * const JoinRoomInvitationRequest_KEY_OPTIONAL_PARAMS;


/**
 Sends an invitation to other users/players to join a specific Room.
 Invitations can be used for different purposes such as playing games, visiting a specific Room, Buddy requests etc...
 
 Depending on the Room's settings this invitation can be sent only by Room's owner or by all other players, with the exception of spectators. This behavior can be changed via the RoomSetting.allowOwnerOnlyInvitation parameter.

 <b>NOTE:</b> spectators in a game Room are not allowed to invite other people.
 
 An invitation can also specify the amount of time given to each invitee to reply. Default is 30 seconds. A positive answer will attempt to join the user in the designated Room.
 For game Rooms the <i>asSpectator</i> flag can be toggled to join the invitee as player or spectator (default = player).
 
 There aren't any specific notifications sent back to the inviter after the invitee's response. Users that have accepted the invitation will join the Room while those who didn't reply or turned down the invitation won't generate any event. In case you want to send specific messages (e.g. chat) you can simply send a private message back to the inviter.
 
 See <RoomSettings>
 
 */
@interface JoinRoomInvitationRequest : BaseRequest
{

@protected
    id<Room> _targetRoom;
    NSArray* _invitedUserNames;
    NSInteger _expirySeconds;
    BOOL _asSpectator;
    id <ISFSObject> _params;
}

@property (nonatomic, strong) id<Room> targetRoom;
@property (nonatomic, strong) NSArray* invitedUserNames;
@property (nonatomic, assign) NSInteger expirySeconds;
@property (nonatomic, assign) BOOL asSpectator;
@property (nonatomic, strong) id <ISFSObject> params;

-(id)initWithInvitedUserNames:(NSArray *)invitedUserNames targetRoom:(id<Room>)room expirySeconds:(NSInteger)secs asSpectator:(BOOL)asSpect params:(id <ISFSObject>)params;

/**
 Sends an invitation to join an existing Room.
 
 @param invitedUserNames an array of online user names to invite in the Room
 @param targetRoom the target Room for the invitation
 @param expirySeconds how much time each invitee has to reply, in seconds (suggested = 30-60 secs)
 @param asSpect indicates whether the invited people will join the target Room as players or spectators 
 @param params optional SFSObject containing custom data about the invitation (e.g. custom message, game info etc...)

 @see [ISFSEvents onInvitationReply:]
 */
+(id)initWithInvitedUserNames:(NSArray *)invitedUserNames targetRoom:(id<Room>)room expirySeconds:(NSInteger)secs asSpectator:(BOOL)asSpect params:(id <ISFSObject>)params;

@end

