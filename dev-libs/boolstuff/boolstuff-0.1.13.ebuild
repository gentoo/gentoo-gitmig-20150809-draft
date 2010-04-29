# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boolstuff/boolstuff-0.1.13.ebuild,v 1.1 2010/04/29 07:40:14 hwoarang Exp $

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
