# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-1.8.9.ebuild,v 1.12 2004/03/30 00:11:28 mr_bones_ Exp $

inherit kde
need-kde 3

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="mirror://sourceforge/cdbakeoven/${P}.tar.bz2"
HOMEPAGE="http://cdbakeoven.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

newdepend ">=media-libs/libogg-1.0_rc2
	virtual/mpg123
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11"
