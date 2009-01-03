# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/yapide/yapide-0.1.1.ebuild,v 1.3 2009/01/03 07:34:53 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Yet Another PIC IDE: a Microchip PIC simulator"
HOMEPAGE="http://www.mtoussaint.de/yapide.html"
SRC_URI="http://www.mtoussaint.de/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/libc
	=x11-libs/qt-3*
	dev-embedded/gputils"

DEPEND="${RDEPEND}"

S="${WORKDIR}/YaPIDE-${PV}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
	epatch "${FILESDIR}"/${P}-make.patch
}

src_compile() {
	addwrite "${QTDIR}/etc/settings"

#	this isn't autoconf
	tc-export CXX
	./configure || die
	emake src/Makefile || die
	sed -i -e "s:^CFLAGS.*-D_REENTRANT:CFLAGS = ${CFLAGS} -D_REENTRANT:" \
		-e "s:^CXXFLAGS.*-D_REENTRANT:CXXFLAGS = ${CXXFLAGS} -D_REENTRANT:" \
		src/Makefile
	emake || die
}

src_install() {
	dobin src/yapide
	dodoc KNOWNBUGS README
}
