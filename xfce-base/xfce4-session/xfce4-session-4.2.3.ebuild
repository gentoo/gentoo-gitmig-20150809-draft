# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.2.3.ebuild,v 1.14 2006/12/28 04:06:22 nichoj Exp $

inherit xfce42

DESCRIPTION="Xfce 4 session manager"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-apps/iceauth )
	virtual/x11 )
	~xfce-base/xfce-utils-${PV}
	>=xfce-base/libxfce4util-4.2.0
	>=xfce-base/libxfcegui4-4.2.0
	>=xfce-base/libxfce4mcs-4.2.0"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libXt
	x11-proto/xproto )
	virtual/x11 )"

core_package
single_make
