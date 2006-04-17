# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-toys/xfce4-toys-4.2.3.ebuild,v 1.5 2006/04/17 18:28:31 hansmi Exp $

inherit xfce42

DESCRIPTION="Xfce 4 panel toys plugin"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce4-panel-${PV}"

core_package
