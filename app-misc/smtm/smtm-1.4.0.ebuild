# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/smtm/smtm-1.4.0.ebuild,v 1.7 2003/03/11 21:11:44 seemant Exp $

DESCRIPTION="Stock ticker, profit/loss calculator and chart tool"
HOMEPAGE="http://eddelbuettel.com/dirk/code/smtm.html"
SRC_URI="http://eddelbuettel.com/dirk/code/smtm/smtm_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-lang/perl-5
	dev-perl/perl-tk
	dev-perl/DateManip
	dev-perl/libwww-perl"

S=${WORKDIR}

src_install() {
	exeinto /usr/bin
	doexe smtm

	dohtml smtm.html
	dodoc BUGS COPYING THANKS TODO
	docinto examples
	dodoc examples/*.smtm
}
