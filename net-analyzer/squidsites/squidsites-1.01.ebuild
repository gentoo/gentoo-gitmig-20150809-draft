# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squidsites/squidsites-1.01.ebuild,v 1.1 2002/08/04 09:23:07 cybersystem Exp $

DESCRIPTION="Squidsites is a tool that parses Squid access log file and generates a report of the most visited sites."
HOMEPAGE="http://www.stefanopassiglia.com/downloads.htm"
SRC_URI="http://www.stefanopassiglia.com/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="ppc x86"
DEPEND="sys-libs/glibc"
RDEPEND="sys-libs/glibc"
S=${WORKDIR}/src

src_compile() {
	emake || die
}

src_install () {
	cd ${WORKDIR}
	dobin src/squidsites 
	dodoc Authors Bugs ChangeLog GNU-Manifesto.html README
}
