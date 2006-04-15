# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-4.2.3.ebuild,v 1.4 2006/04/15 01:55:51 halcy0n Exp $

inherit xfce42

DESCRIPTION="Xfce 4 mcs manager"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"

RDEPEND="|| ( ( x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11 )
	virtual/x11 )
	~xfce-base/libxfce4mcs-${PV}"

core_package
