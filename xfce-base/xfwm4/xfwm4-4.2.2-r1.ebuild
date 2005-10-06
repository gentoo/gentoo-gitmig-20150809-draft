# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfwm4/xfwm4-4.2.2-r1.ebuild,v 1.2 2005/10/06 18:41:10 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce 4 window manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXpm )
	virtual/x11 )
	x11-libs/startup-notification
	~xfce-base/xfce-mcs-manager-${PV}"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
	x11-proto/extproto
	x11-libs/libXt )
	virtual/x11 )"

XFCE_CONFIG="--enable-randr --enable-compositor"
core_package