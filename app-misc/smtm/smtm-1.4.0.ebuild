# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/smtm/smtm-1.4.0.ebuild,v 1.2 2002/07/25 19:18:34 seemant Exp $

DESCRIPTION="Stock ticker, profit/loss calculator and chart tool"
HOMEPAGE="http://eddelbuettel.com/dirk/code/smtm.html"
SRC_URI="http://eddelbuettel.com/dirk/code/smtm/smtm_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=sys-devel/perl-5
	dev-perl/perl-tk
	dev-perl/DateManip
	dev-perl/libwww-perl"

S=${WORKDIR}

src_compile() {
	echo "nothing to compile"
}

src_install () {
	exeinto /usr/bin
	doexe smtm

	dohtml smtm.html
	dodoc BUGS COPYING THANKS TODO
	docinto examples
	dodoc examples/*.smtm
}
