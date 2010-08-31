cdef extern from *:
    unsigned int XNone "None"
    unsigned int PointerWindow
    unsigned int InputFocus
    unsigned int PointerRoot
    unsigned int CurrentTime
    unsigned int IsUnmapped
    unsigned int IsUnviewable
    unsigned int IsViewable
    unsigned int NoEventMask
    unsigned int KeyPressMask
    unsigned int KeyReleaseMask
    unsigned int ButtonPressMask
    unsigned int ButtonReleaseMask
    unsigned int EnterWindowMask
    unsigned int LeaveWindowMask
    unsigned int PointerMotionMask
    unsigned int PointerMotionHintMask
    unsigned int Button1MotionMask
    unsigned int Button2MotionMask
    unsigned int Button3MotionMask
    unsigned int Button4MotionMask
    unsigned int Button5MotionMask
    unsigned int ButtonMotionMask
    unsigned int KeymapStateMask
    unsigned int ExposureMask
    unsigned int VisibilityChangeMask
    unsigned int StructureNotifyMask
    unsigned int ResizeRedirectMask
    unsigned int SubstructureNotifyMask
    unsigned int SubstructureRedirectMask
    unsigned int FocusChangeMask
    unsigned int PropertyChangeMask
    unsigned int ColormapChangeMask
    unsigned int OwnerGrabButtonMask
    unsigned int KeyPress
    unsigned int KeyRelease
    unsigned int ButtonPress
    unsigned int ButtonRelease
    unsigned int MotionNotify
    unsigned int EnterNotify
    unsigned int LeaveNotify
    unsigned int FocusIn
    unsigned int FocusOut
    unsigned int KeymapNotify
    unsigned int Expose
    unsigned int GraphicsExpose
    unsigned int NoExpose
    unsigned int VisibilityNotify
    unsigned int CreateNotify
    unsigned int DestroyNotify
    unsigned int UnmapNotify
    unsigned int MapNotify
    unsigned int MapRequest
    unsigned int ReparentNotify
    unsigned int ConfigureNotify
    unsigned int ConfigureRequest
    unsigned int GravityNotify
    unsigned int ResizeRequest
    unsigned int CirculateNotify
    unsigned int CirculateRequest
    unsigned int PropertyNotify
    unsigned int SelectionClear
    unsigned int SelectionRequest
    unsigned int SelectionNotify
    unsigned int ColormapNotify
    unsigned int ClientMessage
    unsigned int MappingNotify
    unsigned int LASTEvent
    unsigned int PropModeReplace
    unsigned int PropModePrepend
    unsigned int PropModeAppend
    unsigned int CWX
    unsigned int CWY
    unsigned int CWWidth
    unsigned int CWHeight
    unsigned int CWBorderWidth
    unsigned int CWSibling
    unsigned int CWStackMode
    unsigned int Above
    unsigned int Below
    unsigned int BottomIf
    unsigned int TopIf
    unsigned int Opposite
    unsigned int Success
    unsigned int BadRequest
    unsigned int BadValue
    unsigned int BadWindow
    unsigned int BadPixmap
    unsigned int BadAtom
    unsigned int BadCursor
    unsigned int BadFont
    unsigned int BadMatch
    unsigned int BadDrawable
    unsigned int BadAccess
    unsigned int BadAlloc
    unsigned int BadColor
    unsigned int BadGC
    unsigned int BadIDChoice
    unsigned int BadName
    unsigned int BadLength
    unsigned int BadImplementation
    unsigned int FirstExtensionError
    unsigned int LastExtensionError
    unsigned int USPosition
    unsigned int USSize
    unsigned int PPosition
    unsigned int PSize
    unsigned int PMinSize
    unsigned int PMaxSize
    unsigned int PResizeInc
    unsigned int PAspect
    unsigned int PBaseSize
    unsigned int PWinGravity
    unsigned int InputHint
    unsigned int StateHint
    unsigned int IconPixmapHint
    unsigned int IconWindowHint
    unsigned int IconPositionHint
    unsigned int IconMaskHint
    unsigned int WindowGroupHint
    unsigned int XUrgencyHint
    unsigned int WithdrawnState
    unsigned int NormalState
    unsigned int IconicState
    unsigned int RevertToParent
    unsigned int RevertToPointerRoot
    unsigned int RevertToNone
    unsigned int NotifyNormal
    unsigned int NotifyGrab
    unsigned int NotifyUngrab
    unsigned int NotifyAncestor
    unsigned int NotifyVirtual
    unsigned int NotifyInferior
    unsigned int NotifyNonlinear
    unsigned int NotifyNonlinearVirtual
    unsigned int NotifyPointer
    unsigned int NotifyPointerRoot
    unsigned int NotifyDetailNone
    unsigned int GrabModeSync
    unsigned int GrabModeAsync
    unsigned int AnyKey
    unsigned int AnyModifier
const = {
    "XNone": XNone,
    "PointerWindow": PointerWindow,
    "InputFocus": InputFocus,
    "PointerRoot": PointerRoot,
    "CurrentTime": CurrentTime,
    "IsUnmapped": IsUnmapped,
    "IsUnviewable": IsUnviewable,
    "IsViewable": IsViewable,
    "NoEventMask": NoEventMask,
    "KeyPressMask": KeyPressMask,
    "KeyReleaseMask": KeyReleaseMask,
    "ButtonPressMask": ButtonPressMask,
    "ButtonReleaseMask": ButtonReleaseMask,
    "EnterWindowMask": EnterWindowMask,
    "LeaveWindowMask": LeaveWindowMask,
    "PointerMotionMask": PointerMotionMask,
    "PointerMotionHintMask": PointerMotionHintMask,
    "Button1MotionMask": Button1MotionMask,
    "Button2MotionMask": Button2MotionMask,
    "Button3MotionMask": Button3MotionMask,
    "Button4MotionMask": Button4MotionMask,
    "Button5MotionMask": Button5MotionMask,
    "ButtonMotionMask": ButtonMotionMask,
    "KeymapStateMask": KeymapStateMask,
    "ExposureMask": ExposureMask,
    "VisibilityChangeMask": VisibilityChangeMask,
    "StructureNotifyMask": StructureNotifyMask,
    "ResizeRedirectMask": ResizeRedirectMask,
    "SubstructureNotifyMask": SubstructureNotifyMask,
    "SubstructureRedirectMask": SubstructureRedirectMask,
    "FocusChangeMask": FocusChangeMask,
    "PropertyChangeMask": PropertyChangeMask,
    "ColormapChangeMask": ColormapChangeMask,
    "OwnerGrabButtonMask": OwnerGrabButtonMask,
    "KeyPress": KeyPress,
    "KeyRelease": KeyRelease,
    "ButtonPress": ButtonPress,
    "ButtonRelease": ButtonRelease,
    "MotionNotify": MotionNotify,
    "EnterNotify": EnterNotify,
    "LeaveNotify": LeaveNotify,
    "FocusIn": FocusIn,
    "FocusOut": FocusOut,
    "KeymapNotify": KeymapNotify,
    "Expose": Expose,
    "GraphicsExpose": GraphicsExpose,
    "NoExpose": NoExpose,
    "VisibilityNotify": VisibilityNotify,
    "CreateNotify": CreateNotify,
    "DestroyNotify": DestroyNotify,
    "UnmapNotify": UnmapNotify,
    "MapNotify": MapNotify,
    "MapRequest": MapRequest,
    "ReparentNotify": ReparentNotify,
    "ConfigureNotify": ConfigureNotify,
    "ConfigureRequest": ConfigureRequest,
    "GravityNotify": GravityNotify,
    "ResizeRequest": ResizeRequest,
    "CirculateNotify": CirculateNotify,
    "CirculateRequest": CirculateRequest,
    "PropertyNotify": PropertyNotify,
    "SelectionClear": SelectionClear,
    "SelectionRequest": SelectionRequest,
    "SelectionNotify": SelectionNotify,
    "ColormapNotify": ColormapNotify,
    "ClientMessage": ClientMessage,
    "MappingNotify": MappingNotify,
    "LASTEvent": LASTEvent,
    "PropModeReplace": PropModeReplace,
    "PropModePrepend": PropModePrepend,
    "PropModeAppend": PropModeAppend,
    "CWX": CWX,
    "CWY": CWY,
    "CWWidth": CWWidth,
    "CWHeight": CWHeight,
    "CWBorderWidth": CWBorderWidth,
    "CWSibling": CWSibling,
    "CWStackMode": CWStackMode,
    "Above": Above,
    "Below": Below,
    "BottomIf": BottomIf,
    "TopIf": TopIf,
    "Opposite": Opposite,
    "Success": Success,
    "BadRequest": BadRequest,
    "BadValue": BadValue,
    "BadWindow": BadWindow,
    "BadPixmap": BadPixmap,
    "BadAtom": BadAtom,
    "BadCursor": BadCursor,
    "BadFont": BadFont,
    "BadMatch": BadMatch,
    "BadDrawable": BadDrawable,
    "BadAccess": BadAccess,
    "BadAlloc": BadAlloc,
    "BadColor": BadColor,
    "BadGC": BadGC,
    "BadIDChoice": BadIDChoice,
    "BadName": BadName,
    "BadLength": BadLength,
    "BadImplementation": BadImplementation,
    "FirstExtensionError": FirstExtensionError,
    "LastExtensionError": LastExtensionError,
    "USPosition": USPosition,
    "USSize": USSize,
    "PPosition": PPosition,
    "PSize": PSize,
    "PMinSize": PMinSize,
    "PMaxSize": PMaxSize,
    "PResizeInc": PResizeInc,
    "PAspect": PAspect,
    "PBaseSize": PBaseSize,
    "PWinGravity": PWinGravity,
    "InputHint": InputHint,
    "StateHint": StateHint,
    "IconPixmapHint": IconPixmapHint,
    "IconWindowHint": IconWindowHint,
    "IconPositionHint": IconPositionHint,
    "IconMaskHint": IconMaskHint,
    "WindowGroupHint": WindowGroupHint,
    "XUrgencyHint": XUrgencyHint,
    "WithdrawnState": WithdrawnState,
    "NormalState": NormalState,
    "IconicState": IconicState,
    "RevertToParent": RevertToParent,
    "RevertToPointerRoot": RevertToPointerRoot,
    "RevertToNone": RevertToNone,
    "NotifyNormal": NotifyNormal,
    "NotifyGrab": NotifyGrab,
    "NotifyUngrab": NotifyUngrab,
    "NotifyAncestor": NotifyAncestor,
    "NotifyVirtual": NotifyVirtual,
    "NotifyInferior": NotifyInferior,
    "NotifyNonlinear": NotifyNonlinear,
    "NotifyNonlinearVirtual": NotifyNonlinearVirtual,
    "NotifyPointer": NotifyPointer,
    "NotifyPointerRoot": NotifyPointerRoot,
    "NotifyDetailNone": NotifyDetailNone,
    "GrabModeSync": GrabModeSync,
    "GrabModeAsync": GrabModeAsync,
    "AnyKey": AnyKey,
    "AnyModifier": AnyModifier,
}
