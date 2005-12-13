# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/setxkbmap/setxkbmap-0.99.3.ebuild,v 1.2 2005/12/13 18:44:07 cardoe Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

PATCHES=""

DESCRIPTION="X.Org setxkbmap application"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libxkbfile
	x11-libs/libX11"
DEPEND="${RDEPEND}"
