# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dlint/dlint-1.4.0-r1.ebuild,v 1.1 2004/10/19 14:10:26 ticho Exp $

inherit eutils

S=${WORKDIR}/${P/-/}
DESCRIPTION="Dlint analyzes any DNS zone you specify, and reports any problems it finds by displaying errors and warnings"
SRC_URI="http://www.domtools.com/pub/${P/-/}.tar.gz"
HOMEPAGE="http://www.domtools.com/dns/dlint.shtml"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/coreutils
	net-dns/bind-tools
	dev-lang/perl
	app-shells/bash"

src_compile() {
	sed -i -e 's:rrfilt=\"/usr/local/bin/digparse\":rrfilt=\"/usr/bin/digparse\":' \
		dlint
	sed -i -e "s:head -:head -n :g" dlint
	sed -i -e "s:tail +:tail -n +:g" dlint
}

src_install () {
	dobin digparse
	dobin dlint
	doman dlint.1
	dodoc BUGS COPYING INSTALL README CHANGES COPYRIGHT TESTCASES
}
