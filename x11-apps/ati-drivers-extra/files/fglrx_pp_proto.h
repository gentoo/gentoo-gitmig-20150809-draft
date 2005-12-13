/****************************************************************************
 *                                                                          *
 * Copyright 1999-2005 ATI Technologies Inc., Markham, Ontario, CANADA.     *
 * All Rights Reserved.                                                     *
 *                                                                          *
 * Your use and or redistribution of this software in source and \ or       *
 * binary form, with or without modification, is subject to: (i) your       *
 * ongoing acceptance of and compliance with the terms and conditions of    *
 * the ATI Technologies Inc. software End User License Agreement; and (ii)  *
 * your inclusion of this notice in any version of this software that you   *
 * use or redistribute.  A copy of the ATI Technologies Inc. software End   *
 * User License Agreement is included with this software and is also        *
 * available by contacting ATI Technologies Inc. at http://www.ati.com      *
 *                                                                          *
 ****************************************************************************/

/** \file powerplay.h
 * \brief Protocol definitions for the ATI POWERplay extension
 * \author Felix Kuehling
 */

#ifndef __FGLRX_PP_PROTO_H
#define __FGLRX_PP_PROTO_H

#ifndef XREP_SZ
#define XREP_SZ(name)       sizeof(x##name##Reply)
#endif
#ifndef XREQ_SZ
#define XREQ_SZ(name)       sizeof(x##name##Req)
#endif

#define X_FGLQueryPowerPlayInfo        13
#define X_FGLQueryPowerState           14
#define X_FGLSetPowerState             15

/*****************************************************************************
 * FGLQueryPowerPlayInfo                                                     */
typedef struct _FGLQueryPowerPlayInfo {
    CARD8   reqType;
    CARD8   fireglReqType;
    CARD16  length B16;
    /* specific */
    CARD32  screen B32;
} xFGLQueryPowerPlayInfoReq;

typedef struct {
    BYTE    type;                   /* X_Reply */
    BYTE    pad1;
    CARD16  sequenceNumber B16;
    CARD32  length B32;
    /* specific */
    CARD16  extVersion B16;
    CARD16  extRevision B16;
    CARD16  ppVersion B16;
    CARD16  numPowerStates B16;
    CARD32  flags B32;
    CARD32  pad2 B32;
    CARD32  pad3 B32;
    CARD32  pad4 B32;
} xFGLQueryPowerPlayInfoReply;

#define sz_xFGLQueryPowerPlayInfoReq      XREQ_SZ(FGLQueryPowerPlayInfo)
#define sz_xFGLQueryPowerPlayInfoReply    XREP_SZ(FGLQueryPowerPlayInfo)

/*****************************************************************************
 * FGLQueryPowerState                                                        */
typedef struct _FGLQueryPowerState {
    CARD8   reqType;
    CARD8   fireglReqType;
    CARD16  length B16;
    /* specific */
    CARD32  screen B32;
    CARD16  state B16;
    CARD16  pad1 B16;
} xFGLQueryPowerStateReq;

typedef struct {
    BYTE    type;                   /* X_Reply */
    BYTE    pad1;
    CARD16  sequenceNumber B16;
    CARD32  length B32;
    /* specific */
    CARD32  flags B32;
    CARD32  validEvents B32;
    CARD32  memClock B32;
    CARD32  coreClock B32;
    CARD32  refreshRate B32;
    CARD16  upperTempLimit B16;
    CARD16  lowerTempLimit B16;
    CARD16  nextUpperTempState B16;
    CARD16  nextLowerTempState B16;
} xFGLQueryPowerStateReply;

#define sz_xFGLQueryPowerStateReq      XREQ_SZ(FGLQueryPowerState)
#define sz_xFGLQueryPowerStateReply    XREP_SZ(FGLQueryPowerState)

/*****************************************************************************
 * FGLSetPowerState                                                          */
typedef struct _FGLSetPowerState {
    CARD8   reqType;
    CARD8   fireglReqType;
    CARD16  length B16;
    /* specific */
    CARD32  screen B32;
    CARD16  event B16;
    CARD16  state B16;
} xFGLSetPowerStateReq;

typedef struct {
    BYTE    type;                   /* X_Reply */
    BYTE    pad1;
    CARD16  sequenceNumber B16;
    CARD32  length B32;
    /* specific */
    CARD32  result B32;
    CARD32  pad2 B32;
    CARD32  pad3 B32;
    CARD32  pad4 B32;
    CARD32  pad5 B32;
    CARD32  pad6 B32;
} xFGLSetPowerStateReply;

#define sz_xFGLSetPowerStateReq      XREQ_SZ(FGLSetPowerState)
#define sz_xFGLSetPowerStateReply    XREP_SZ(FGLSetPowerState)

#endif /* __FGLRX_PP_PROTO_H */
