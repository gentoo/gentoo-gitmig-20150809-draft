# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tmake/tmake-2.12.ebuild,v 1.7 2010/04/06 09:25:20 abcd Exp $

EAPI="3"

DESCRIPTION="A Cross platform Makefile tool"
SRC_URI="mirror://sourceforge/tmake/${P}.tar.bz2"
HOMEPAGE="http://tmake.sourceforge.net"

RDEPEND=">=dev-lang/perl-5"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~s390 ~sparc ~x86 ~x86-linux ~ppc-macos"
IUSE=""

src_install () {
	dobin bin/tmake bin/progen
	dodir /usr/lib/tmake
	cp -pPRf "${S}"/lib/* "${ED}"/usr/lib/tmake
	dodoc README
	dohtml -r doc/*
	echo "TMAKEPATH=\"${EPREFIX}/usr/lib/tmake/linux-g++\"" > "${T}"/51tmake
	doenvd "${T}"/51tmake
}

