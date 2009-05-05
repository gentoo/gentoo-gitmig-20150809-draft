# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xgamma/xgamma-1.0.1.ebuild,v 1.8 2009/05/05 07:55:38 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Alter a monitor's gamma correction through the X server"

KEYWORDS="alpha amd64 arm mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RDEPEND="x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"
