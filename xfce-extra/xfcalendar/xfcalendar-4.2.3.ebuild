# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfcalendar/xfcalendar-4.2.3.ebuild,v 1.13 2006/12/28 04:16:46 nichoj Exp $

inherit xfce42

DESCRIPTION="Xfce4 calendar"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce4-panel-${PV}
	>=xfce-base/libxfce4mcs-4.2.0
	>=xfce-base/libxfcegui4-4.2.0"

core_package
