# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.27.0.ebuild,v 1.3 2004/03/18 15:37:15 pyrania Exp $

DESCRIPTION="script for managaging file archives of various types (atr,tar+gzip,zip,etc)"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/${P}.tar.gz"
HOMEPAGE="http://www.student.lu.se/~nbi98oli/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="dev-lang/perl"

src_install() {
	dobin atool
	dosym atool /usr/bin/acat
	dosym atool /usr/bin/adiff
	dosym atool /usr/bin/als
	dosym atool /usr/bin/apack
	dosym atool /usr/bin/aunpack
	dodoc ChangeLog TODO README COPYING NEWS
	doman atool.1
}
