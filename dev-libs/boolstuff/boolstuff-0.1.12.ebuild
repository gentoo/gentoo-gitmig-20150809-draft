# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boolstuff/boolstuff-0.1.12.ebuild,v 1.1 2009/05/30 18:16:18 hwoarang Exp $

EAPI="2"

DESCRIPTION="A C++ library that supports a few operations on boolean expression binary trees."
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev/boolstuff.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

src_configure(){
	econf $(use_enable static)
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
}
