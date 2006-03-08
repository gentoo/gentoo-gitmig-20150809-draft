# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jam/jam-2.5-r3.ebuild,v 1.4 2006/03/08 07:37:04 corsair Exp $

inherit eutils

DESCRIPTION="Just Another Make - advanced make replacement"
HOMEPAGE="http://www.perforce.com/jam/jam.html"
SRC_URI="ftp://ftp.perforce.com/pub/jam/${P}.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc-macos ~ppc64 sparc ~x86"
IUSE=""

DEPEND="sys-devel/bison
	!dev-util/boost-jam"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cxx.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
	epatch "${FILESDIR}"/${P}-dependency.patch
}

src_compile() {
	# The bootstrap makefile assumes ${S} is in the path
	env PATH="${PATH}:${S}" \
	emake -j1 \
		YACC="bison -y" \
		CFLAGS="${CFLAGS}" \
		|| die
}

src_install() {
	BINDIR="${D}/usr/bin" ./jam0 install || die
	dohtml Jam.html Jambase.html Jamfile.html
	dodoc README RELNOTES Porting
}
