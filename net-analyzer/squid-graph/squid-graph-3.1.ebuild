# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squid-graph/squid-graph-3.1.ebuild,v 1.5 2004/05/01 01:00:30 port001 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Squid logfile analyzer and traffic grapher"
HOMEPAGE="http://squid-graph.securlogic.com/"
SRC_URI="http://squid-graph.securlogic.com/files/stable/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86 sparc"

DEPEND="dev-perl/GD"

src_install () {
	dobin bin/apacheconv bin/generate.cgi bin/squid-graph bin/timeconv
	dodoc docs/CHANGELOG docs/README
	dohtml docs/html/*
	prepalldocs
}

pkg_postinst () {
	einfo "Remember to copy /usr/share/doc/${P}/html/logo.png to your output directory"
}


