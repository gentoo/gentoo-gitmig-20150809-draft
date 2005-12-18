# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xeyes/xeyes-1.0.0.ebuild,v 1.1 2005/12/18 19:32:59 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xeyes application"
KEYWORDS="~amd64 ~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
