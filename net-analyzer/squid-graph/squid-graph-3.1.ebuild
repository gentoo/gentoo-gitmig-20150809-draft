# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squid-graph/squid-graph-3.1.ebuild,v 1.10 2007/07/11 23:49:24 mr_bones_ Exp $

DESCRIPTION="Squid logfile analyzer and traffic grapher"
HOMEPAGE="http://squid-graph.securlogic.com/"
SRC_URI="http://squid-graph.securlogic.com/files/stable/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 sparc"
IUSE=""

DEPEND="dev-perl/GD"

src_install () {
	dobin bin/apacheconv bin/generate.cgi bin/squid-graph bin/timeconv
	dodoc docs/CHANGELOG docs/README
	dohtml docs/html/*
	prepalldocs
}

pkg_postinst () {
	elog "Remember to copy /usr/share/doc/${P}/html/logo.png to your output directory"
}
