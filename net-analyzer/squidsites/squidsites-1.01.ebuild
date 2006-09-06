# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squidsites/squidsites-1.01.ebuild,v 1.6 2006/09/06 13:10:48 blubb Exp $

IUSE=""
DESCRIPTION="Squidsites is a tool that parses Squid access log file and generates a report of the most visited sites."
HOMEPAGE="http://www.stefanopassiglia.com/downloads.htm"
SRC_URI="http://www.stefanopassiglia.com/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ppc x86"
DEPEND="virtual/libc"
RDEPEND="virtual/libc"
S=${WORKDIR}/src

src_compile() {
	emake || die
}

src_install () {
	cd ${WORKDIR}
	dobin src/squidsites
	dodoc Authors Bugs ChangeLog GNU-Manifesto.html README
}
