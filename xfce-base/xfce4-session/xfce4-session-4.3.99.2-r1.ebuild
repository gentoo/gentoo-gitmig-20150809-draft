# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.3.99.2-r1.ebuild,v 1.6 2007/01/06 18:45:14 nichoj Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 session manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug hal"

RDEPEND="|| ( ( x11-libs/libX11
		x11-libs/libSM
		x11-apps/iceauth )
		virtual/x11 )
		~xfce-base/xfce-utils-${PV}
		games-misc/fortune-mod
		hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
		|| ( x11-libs/libXt virtual/x11 )"

XFCE_CONFIG="${XFCE_CONFIG} $(use_with hal shutdown-style hal)"
xfce44_core_package
