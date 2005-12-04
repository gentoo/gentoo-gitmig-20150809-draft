# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbiff/xbiff-0.99.2.ebuild,v 1.1 2005/12/04 21:54:13 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xbiff application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
IUSE="xprint"
RDEPEND="x11-libs/libXaw
	x11-misc/xbitmaps"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"
