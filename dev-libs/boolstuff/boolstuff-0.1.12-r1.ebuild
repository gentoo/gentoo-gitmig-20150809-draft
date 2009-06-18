# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boolstuff/boolstuff-0.1.12-r1.ebuild,v 1.1 2009/06/18 13:11:46 hwoarang Exp $

EAPI="2"

DESCRIPTION="A C++ library that supports a few operations on boolean expression binary trees."
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev/boolstuff.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

src_prepare(){
	# Since gcc-4.4 getopt returns -1 instead of EOF. Works for <gcc-4.3 as well
	sed -i "s/EOF/-1/" src/commands/booldnf.cpp || die "gcc-4.4 sed failed"
}

src_configure(){
	econf $(use_enable static)
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
}
