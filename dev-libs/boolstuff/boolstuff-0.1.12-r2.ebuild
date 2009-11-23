# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boolstuff/boolstuff-0.1.12-r2.ebuild,v 1.1 2009/11/23 20:10:33 hwoarang Exp $

EAPI="2"

inherit autotools

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
	#fix documentation installation
	sed -i "s/doc\/\$(PACKAGE)-\$(VERSION)/doc\/${PF}/" \
		Makefile.am || die "failed to fix docdir"
	eautoreconf

}

src_configure(){
	econf $(use_enable static)
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
}
