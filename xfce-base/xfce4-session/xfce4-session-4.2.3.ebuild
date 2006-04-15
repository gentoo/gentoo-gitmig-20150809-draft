# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.2.3.ebuild,v 1.4 2006/04/15 01:58:05 halcy0n Exp $

inherit xfce42

DESCRIPTION="Xfce 4 session manager"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce-utils-${PV}"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libXt
	x11-proto/xproto )
	virtual/x11 )"

core_package
single_make
