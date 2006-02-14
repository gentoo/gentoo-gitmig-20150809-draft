# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlogo/xlogo-1.0.1.ebuild,v 1.2 2006/02/14 21:30:51 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xlogo application"
KEYWORDS="~amd64 ~arm ~mips ~ppc64 ~s390 ~sparc ~x86"
# Broken without xprint
#IUSE="xprint"
RDEPEND="x11-libs/libXrender
	x11-libs/libXaw
	x11-libs/libXprintUtil"
#	xprint? ( x11-libs/libXprintUtil )"
DEPEND="${RDEPEND}"

#CONFIGURE_OPTIONS="$(use_enable xprint)"
