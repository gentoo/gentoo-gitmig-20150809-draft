# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squid-graph/squid-graph-3.0.ebuild,v 1.1 2002/08/12 08:55:39 cybersystem Exp $

DESCRIPTION="Squid logfile analyzer and traffic grapher"
HOMEPAGE="http://www.squid-graph.dhs.org"
SRC_URI="http://www.squid-graph.dhs.org/files/stable/${P}.tar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 sparc sparc64"
DEPEND="sys-devel/perl"
RDEPEND="sys-devel/perl"
S=${WORKDIR}/${P}

src_install () {
	dobin bin/apacheconv bin/generate.cgi bin/squid-graph bin/timeconv
	dodoc docs/CHANGELOG docs/README
	dohtml docs/html/*
}

pkg_postinst () {
	einfo "Remember to copy /usr/share/doc/${P}/html/logo.png to your output directory"
}
