# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dlint/dlint-1.4.0.ebuild,v 1.12 2004/07/14 23:23:13 agriffis Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dlint analyzes any DNS zone you specify, and reports any problems it finds by displaying errors and warnings"
SRC_URI="http://www.domtools.com/pub/${MY_P}.tar.gz"
HOMEPAGE="http://www.domtools.com/dns/dlint.shtml"

SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""
LICENSE="GPL-2"

DEPEND="net-dns/bind-tools
	dev-lang/perl
	app-shells/bash"

src_compile() {

	mv dlint dlint.orig
	sed 's:rrfilt=\"/usr/local/bin/digparse\":rrfilt=\"/usr/bin/digparse\":' \
		dlint.orig > dlint

}

src_install () {

	dobin digparse
	dobin dlint

	doman dlint.1

	dodoc BUGS COPYING INSTALL README CHANGES COPYRIGHT TESTCASES
}
