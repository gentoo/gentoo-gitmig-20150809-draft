# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dlint/dlint-1.4.1.ebuild,v 1.1 2008/04/24 16:44:16 ticho Exp $

inherit eutils fixheadtails

S=${WORKDIR}/${P/-/}
DESCRIPTION="Dlint analyzes any DNS zone you specify, and reports any problems."
SRC_URI="http://www.domtools.com/pub/${P/-/}.tar.gz"
HOMEPAGE="http://www.domtools.com/"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/coreutils
	net-dns/bind-tools
	dev-lang/perl
	app-shells/bash"

src_compile() {
	sed -i -e 's:rrfilt=\"/usr/local/bin/digparse\":rrfilt=\"digparse\":' dlint
	ht_fix_file dlint
}

src_install () {
	dobin digparse
	dobin dlint
	doman dlint.1
	dodoc BUGS INSTALL README CHANGES COPYRIGHT TESTCASES
}
