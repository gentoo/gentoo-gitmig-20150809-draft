# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tmake/tmake-2.12.ebuild,v 1.2 2005/08/23 18:05:30 flameeyes Exp $

DESCRIPTION="A Cross platform Makefile tool"
SRC_URI="mirror://sourceforge/tmake/${P}.tar.bz2"
HOMEPAGE="http://tmake.sourceforge.net"

RDEPEND=">=dev-lang/perl-5"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~ia64"
IUSE=""

src_install () {
	cd ${S}
	dobin bin/tmake bin/progen
	dodir /usr/lib/tmake
	cp -pPRf ${S}/lib/* ${D}/usr/lib/tmake
	dodoc CHANGES LICENSE README
	dohtml -r doc/*
	dodir /etc/env.d
	echo "TMAKEPATH=/usr/lib/tmake/linux-g++" > ${D}/etc/env.d/51tmake
}
