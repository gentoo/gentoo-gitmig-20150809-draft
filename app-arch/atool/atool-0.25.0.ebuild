# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.25.0.ebuild,v 1.10 2005/01/01 11:41:22 eradicator Exp $

DESCRIPTION="script for managing file archives of various types (atr,tar+gzip,zip,etc)"
HOMEPAGE="http://www.student.lu.se/~nbi98oli/"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	dobin acat adiff als apack atool aunpack || die
	dodoc ChangeLog TODO README
	doman atool.1
}
