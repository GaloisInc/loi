
void init()
{
	// holds the authorizations allowed and granted per CUCS
	gAuthMap = some sort of map list of active CUCS Auth Messages
	g45CUCS = pointer to CUCS auth message/info that has LOI 4/5
	gOverride45 = true if CUCS with 4/5 is overriding

	gVehicleID =  Int4 from settings
	gVehicleType = integer from settings
	gVehicleSubType = integer from settings
}


// called from decryption component for incoming messages
void processIncoming(char buf[576])
{
	if (getMessageType(buf) == CUCS_AUTHORIZATION_REQUEST)
	{
		CUCSAuthorizationRequest req = parseMessage(buf)
		handleCucsAuthorizationRequest(req);
		AckAuthorizationRequest(req);
		return;
	}

	if (ApplyLoiMessageFilter(buf))
	{
		nextComponent.processIncoming(msg);  // next could be flight VSM or camera VSM
	}
}

void AckAuthorizationRequest(CUCSAuthorizationRequest req)
{
	MessageAck ack;
	ack.setOriginalMessageTimeStamp( req->getTimeStamp() );
	ack.setOriginalMessageInstanceID( req->getMsgInstance() );
	ack.setOriginalMessageType( req->getMessageType() );
	ack.setCucsId(req->getCucsId());
    ack.setTimeStamp();
    ack.setVehicleId( gVehicleId );
    ack.setVSMID( gVehicleId );
    processOutgoing(&ack);
}

void SendAuthorizationResponse(VsmAuthorizationResponse resp)
{
    resp.setTimeStamp();
    resp.setVehicleId(gVehicleId);
    resp.setVSMID(gVehicleId);
	processOutgoing(msg);
}

void getRequiredLOI(int messageType)
{
	case statement that maps messageType to an LOI bit
}

bool ApplyLoiMessageFilter(buf[576])
{
	cucsId = buf[42:46]
	messageType = buf[14:18]
    VsmAuthorizationResponse response = GetCucsAuthorization( cucsId );

    if( NULL != response)
	{
		if ( getRequiredLOI(messageType) & response.loiGranted )
		{
			return true;
		}

		if (messageType == FIELDCONFIGREQ)
		{
			return true;
		}
	}
	return false;
}

// called from end VSM component (flight or camera) that is sending data to the network
void processOutgoing(char buf[576])
{
	cucsID = buf[42:46];
	messageType = buf[14:18];
	
	if ( cucsID is broadcast )
	{
		for (each active cucs authMessage)
		{
			if ( getRequiredLOI(messageType) & authMessage.getLOI_Granted() ) 
			{
				buf[42:46] = active CUCS id
				send to encryption component
 			}
		}
	}
	else // single CUCS
	{
		if ( getRequiredLOI(messageType) & authMessage->getLOI_Granted() )
		{
			sendToEncryption(buf)
		}
	}
}

VsmAuthorizationResponse GetCucsAuthorization(int cucsID)
{
	if( 0 == cucsID)
		return NULL;

    VsmAuthorizationResponse response;

	if (cucsId in gAuthMap)
	{
		response = gAuthMap.get(cucsId)
	}
	else if ( gAuthMap.size() < MAX_NUM_CUCS )
	{
		response = new VsmAuthorizationResponse;
		response->setCucsId(cucsID);
		response->setVehicleType(mVehicleType);
		response->setVehicleSubType(mVehicleSubType);
	}
	else
	{  // not authorized or map is full
		response = NULL;
	}


	if ( NULL != response )
	{
		// allow either LOI 4 or 5 but not both
		// only authorize LOI 4/5 if some other CUCS does not already have it
		// bwilson: not sure if I understand this part myself
		authorized = LOI_2;
		if (g45CUCS is null  or cucsId is g45CUCSId and LOI granted is 4 or 5)
		{
			authorized |= (LOI_4 | LOI_5);
		}
	}
    else
    {
		authorized = 0;
    }

	response->setLOI_Authorized(authorized);
	return response;
}


VsmAuthorizationResponse UpdateCucsAuthorization(CucsAuthorizationRequest request)
{
	VsmAuthorizationResponse* response = GetCucsAuthorization(request.cucsId);

	response->setLOI_Authorized( UNSPECIFIED_LOI );
	prevgranted = response->getLOI_Granted();

	if (RELINQUISH_HANDOFF_CONTROL == request->GetControlledStationMode())
	{
		if (requestedLOI has LOI_5 and prevgranted has LOI_5)
		{
			if (g45CUCS != NULL) && (request.cucsId == g45CUCS.cucsId)
			{
				g45CUCS.loiGranted &= ~LOI_5;
				g45CUCS = NULL;
				gOverride45 = false;
			}
		}

		if (requestedLOI has LOI_4 and prevgranted has LOI_4)
		{
			if (g45CUCS != NULL) && (request.cucsId == g45CUCS.cucsId)
			{
				g45CUCS.loiGranted &= ~LOI_4;
				g45CUCS = NULL;
				gOverride45 = false;
			}
		}

		if (requestedLOI has LOI_3 and prevgranted has LOI_3)
		{
			// probably do something here with camera LOI
		}

		if (requestedLOI has LOI_2 and prevgranted has LOI_2)
		{
			response.loiGranted &= ~LOI_2;

            //Check if no longer Authorized
            if ( response.loiGranted == 0 )
			{
				gAuthMap.remove(response.cucsId);
			}
		}

		VsmAuthorizationResponse authResp;
		authResp.fastCopy( *response );
       	authResp.setLOI_Granted( request->GetRequestedLoi() );
		authResp.setControlledStation( LOI_3 == (request->GetRequestedLoi() & LOI_3) ? request->GetControlledStation() : 0 );
		authResp.setControlledStationMode( RELINQUISH_CONTROL );
		SendAuthorizationResponse( &authResp );
	}
	else	// This must be an authorization request.
	{
		if (requestedLOI has LOI_2 and prevgranted does not have LOI_2)
		{
            response->setLOI_Granted( LOI_2 );
			gAuthMap[request.cucsId] = response;
		}


		// determine if CUCS wants any payload control
		if (requestedLOI has LOI_3)
		{
		}

		// determine if CUCS wants AV control
		if (requestedLOI has LOI_4)
		{
			if ( g45CUCS is NULL or g45CUCS.cucsId == request.cucsId ) 
			{
				// no cucs has control or this controlling cucs is changing its current LOI
				if ( g45CUCS is NULL )
				{
					// remember who has control of this AV
					g45CUCS = response;
				}
				else if ( loiGranted has LOI_5 )
				{
					// downgrade from 5 to 4
					g45CUCS.loiGranted &= ~LOI_5
				}

				g45CUCS.loiGranted |= LOI_4

				if(OVERRIDE_CONTROL == request->GetControlledStationMode())
				{
					gOverride45 = true;
				}
				else if(REQUEST_CONTROL == request->GetControlledStationMode())
				{
					gOverride45 = false;
				}
			}
			else
			{
				// a cucs has control, can the requesting cucs override?
				if(OVERRIDE_CONTROL == request->GetControlledStationMode() && !gOverride45)
				{
					gOverride45 = true;

					g45CUCS->setLOI_Authorized( UNSPECIFIED_LOI );
					g45CUCS->setLOI_Granted( g45CUCS->getLOI_Granted() & ~LOI_4 );
					g45CUCS->setControlledStationMode( RELINQUISH_CONTROL );

					// notify former CUCS in control of loss of LOI 4
					VsmAuthorizationResponse authResp;
					authResp.fastCopy( *g45CUCS );
					authResp.setLOI_Granted( LOI_4 );
					authResp.setControlledStation( 0 );
					authResp.setControlledStationMode( RELINQUISH_CONTROL );
					SendAuthorizationResponse( &authResp );

					// remember who has control of this AV
					g45CUCS = response;
					g45CUCS->setLOI_Granted( g45CUCS->getLOI_Granted() | LOI_4 );
				}
			}
		}

		// determine if CUCS wants AV and recovery control
		if (requestedLOI has LOI_5)
		{
			if ( g45CUCS is NULL or g45CUCS.cucsId == request.cucsId ) 
			{
				// no cucs has control or this controlling cucs is changing its current LOI
				if ( NULL == g45CUCS )
				{
					g45CUCS = response;
				}
				else if ( loiGranted has LOI_4 )
				{
					// upgrade from 4 to 5
					g45CUCS.loiGranted &= ~LOI_4; 
				}

				g45CUCS.loiGranted |= LOI_5;

				if ( OVERRIDE_CONTROL == request->GetControlledStationMode() )
				{
					g45Override = true;
				}
				else if ( REQUEST_CONTROL == request->GetControlledStationMode() )
				{
					g45Override = false;
				}
			}
			else
			{
				// a cucs has control, can the requesting cucs override?
				if ( OVERRIDE_CONTROL == request->GetControlledStationMode() && !g45Override )
				{
					g45Override = true;

				// Update the authorization table entry for the CUCS which was overridden.
					g45CUCS->setLOI_Authorized( UNSPECIFIED_LOI );
					g45CUCS->setLOI_Granted( g45CUCS->getLOI_Granted() & ~LOI_5 );
					g45CUCS->setControlledStationMode( RELINQUISH_CONTROL );

				// notify former CUCS in control of loss of LOI 5
					VsmAuthorizationResponse authResp;
					authResp.fastCopy( *g45CUCS );
					authResp.setLOI_Granted( LOI_5 );
					authResp.setControlledStation( 0 );
					authResp.setControlledStationMode( RELINQUISH_CONTROL );
					SendAuthorizationResponse( &authResp );

					// remember who has control of this AV
					g45CUCS = response;
					g45CUCS->setLOI_Granted( g45CUCS->getLOI_Granted() | LOI_5 );
				}
			}
		}

	    // Respond with the overall LOIs/stations granted.
		response->setControlledStationMode( TAKE_CONTROL );
		SendAuthorizationResponse( response );
	}

	return response;
}


void handleCucsAuthorizationRequest(CucsAuthorizationRequest request)
{
	VsmAuthorizationResponse response;

	// Check for a broadcast message
	if(STANAG_BROADCAST_ID == request->getVehicleId())
	{
		// Get the LOI authorized.
		response = GetCucsAuthorization(request.cucsId);
		if(NULL == response)
			return;

		if( UNSPECIFIED_LOI != response->getLOI_Authorized() )
		{
			// If CUCS is authorized to some level, respond with authorized LOIs/stations.
			VsmAuthorizationResponse authResp;
			authResp.fastCopy( *response );
			authResp.setLOI_Granted( UNSPECIFIED_LOI );
			authResp.setControlledStationMode( TAKE_CONTROL );
			SendAuthorizationResponse( &authResp );
		}

		if ( UNSPECIFIED_LOI != response->getLOI_Granted() && mVehicleID.getValue() == request->getVehicleId())
		{
			response->setLOI_Authorized( response->getLOI_Granted() );
			response->setControlledStationMode( REQUEST_CONTROL );
			SendAuthorizationResponse( response );
		}

		// Do not respond if the CUCS is not authorized.
	}
	else	// Message was sent directly to this VSM.
	{
		if ( OVERRIDE_CONTROL == request->GetControlledStationMode() )
		{
			// Disallow overrides for all but preferred CUCSs.
			if ( 0x00800000 != (0x00800000 & request->getCucsId()) )
				request->SetControlledStationMode( REQUEST_CONTROL );
		}

		// Resolve the authorization request.
		UpdateCucsAuthorization( request );

		if( requestedLOI has LOI_2 )
		{
			// If CUCS is authorized to some level, respond with authorized LOIs/stations.
			response = GetCucsAuthorization(request.cucsId);
			VsmAuthorizationResponse authResp;

			authResp.fastCopy( *response );
			authResp.setLOI_Granted( UNSPECIFIED_LOI );
			authResp.setControlledStationMode( TAKE_CONTROL );

			SendAuthorizationResponse( &authResp );

			// check and send status messages here if CUCS table is full or getting full
		}
	}
}


