# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.28.0.ebuild,v 1.7 2005/03/27 00:34:24 hansmi Exp $

DESCRIPTION="script for managing file archives of various types (atr,tar+gzip,zip,etc)"
HOMEPAGE="http://www.student.lu.se/~nbi98oli/"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	dobin atool || die
	dosym atool /usr/bin/acat
	dosym atool /usr/bin/adiff
	dosym atool /usr/bin/als
	dosym atool /usr/bin/apack
	dosym atool /usr/bin/aunpack
	dodoc ChangeLog TODO README NEWS
	doman atool.1
}
