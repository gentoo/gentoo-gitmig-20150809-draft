# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/erec/erec-2.2.0.1.ebuild,v 1.1 2004/03/18 15:44:17 eradicator Exp $

DESCRIPTION="A shared audio recording server"
HOMEPAGE="http://bisqwit.iki.fi/source/erec.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/glibc"
DEPEND="sys-apps/sed"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:BINDIR=/usr/local/bin:BINDIR=${D}usr/bin:" \
		-e "s:^\\(ARGHLINK.*-L.*\\):#\\1:" \
		-e "s:^#\\(ARGHLINK=.*a\\)$:\\1:" \
		-e "s:\$(CXX):\$(CXX) \$(CXXFLAGS) -I${S}/argh:g" \
		Makefile

	sed -i \
		 -e 's:CPPFLAGS=:CPPFLAGS=-I/var/tmp/portage/erec-2.2.0.1/work/erec-2.2.0.1/argh :' \
		Makefile.sets

	echo "" > .depend
	echo "" > argh/.depend
}


src_compile() {
	emake -j1 || die
}

src_install() {
	dobin erec
	dodoc README COPYING
	dohtml README.html
}
