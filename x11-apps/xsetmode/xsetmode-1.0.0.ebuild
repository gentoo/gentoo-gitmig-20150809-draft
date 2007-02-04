# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetmode/xsetmode-1.0.0.ebuild,v 1.6 2007/02/04 18:34:06 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="set the mode for an X Input device"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXi
	x11-libs/libX11"
DEPEND="${RDEPEND}"
