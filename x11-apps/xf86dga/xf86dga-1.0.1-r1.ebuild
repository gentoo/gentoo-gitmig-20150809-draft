# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xf86dga/xf86dga-1.0.1-r1.ebuild,v 1.2 2006/06/30 14:56:36 wolf31o2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xf86dga application"
KEYWORDS="amd64 ~arm ~mips ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXxf86dga"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/${P}-setuid.diff"
