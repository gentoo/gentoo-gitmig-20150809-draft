# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dlint/dlint-1.4.0-r2.ebuild,v 1.4 2008/01/21 18:30:59 welp Exp $

inherit eutils fixheadtails

S=${WORKDIR}/${P/-/}
DESCRIPTION="Dlint analyzes any DNS zone you specify, and reports any problems it finds by displaying errors and warnings"
SRC_URI="http://www.domtools.com/pub/${P/-/}.tar.gz"
HOMEPAGE="http://www.domtools.com/dns/dlint.shtml"

SLOT="0"
KEYWORDS="~amd64 sparc x86"
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
	ht_fix_file dlint
	sed -i -e "s:+\$i:-n +\$i:g" dlint
}

src_install () {
	dobin digparse
	dobin dlint
	doman dlint.1
	dodoc BUGS INSTALL README CHANGES COPYRIGHT TESTCASES
}
