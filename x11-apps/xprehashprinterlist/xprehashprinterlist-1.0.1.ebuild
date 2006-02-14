# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xprehashprinterlist/xprehashprinterlist-1.0.1.ebuild,v 1.2 2006/02/14 21:44:10 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xprehashprinterlist application"
KEYWORDS="~arm ~mips ~ppc64 ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXp"
DEPEND="${RDEPEND}"
