# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-appfinder/xfce4-appfinder-4.2.3.ebuild,v 1.5 2006/04/17 18:27:13 hansmi Exp $

inherit xfce42

DESCRIPTION="Xfce 4 application finder"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/libxfce4mcs-${PV}"

core_package
