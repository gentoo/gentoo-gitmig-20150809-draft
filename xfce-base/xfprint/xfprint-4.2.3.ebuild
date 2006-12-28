# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.2.3.ebuild,v 1.14 2006/12/28 03:39:24 nichoj Exp $

inherit xfce42

DESCRIPTION="Xfce 4 print manager panel plugin"
LICENSE="BSD"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce4-panel-${PV}
	~xfce-base/libxfcegui4-${PV}
	>=xfce-base/libxfce4util-4.2.0
	app-text/a2ps
	app-text/psutils"

core_package
