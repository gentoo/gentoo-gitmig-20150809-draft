# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airtraf/airtraf-1.0.ebuild,v 1.1 2003/01/30 05:57:04 latexer Exp $

DESCRIPTION="AirTraf 802.11b Wireless traffic sniffer"
HOMEPAGE="http://www.elixar.com/"
SRC_URI="http://www.elixar.com/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=net-libs/libpcap-0.7.1"

src_compile() {
	cd ${S}/src

	# Do some sedding to make compile flags work

	sed -i "s:gcc:${CC}:" Makefile.rules
	sed -i "s:CFLAGS   = -Wall -O2:CFLAGS   = ${CFLAGS} -Wall:" Makefile.rules
	sed -i "s:c++:${GXX}:" Makefile.rules
	sed -i "s:CXXFLAGS = -Wall -O2:CXXFLAGS = ${GXXFLAGS} -Wall:" Makefile.rules
	make || die
}

src_install () {
	newdoc ${S}/docs/airtraf_doc.html airtraf_documentation.html

	dobin ${S}/src/airtraf || die
}
