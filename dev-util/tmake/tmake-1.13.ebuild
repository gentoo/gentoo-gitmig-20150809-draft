# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tmake/tmake-1.13.ebuild,v 1.4 2012/02/12 15:44:20 armin76 Exp $

DESCRIPTION="A Cross platform Makefile tool"
SRC_URI="ftp://ftp.trolltech.com/freebies/tmake/${P}.tar.gz"
HOMEPAGE="http://www.trolltech.com/products/download/freebies/tmake.html"

RDEPEND="dev-lang/perl"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~ppc ~x86"
IUSE=""

src_install() {
	dobin bin/tmake bin/progen
	dodir /usr/lib/tmake
	cp -af "${S}"/lib/* "${D}"/usr/lib/tmake
	dodoc CHANGES README
	dohtml -r doc/*
	dodir /etc/env.d
	echo "TMAKEPATH=/usr/lib/tmake/linux-g++" > ${D}/etc/env.d/51tmake
}
