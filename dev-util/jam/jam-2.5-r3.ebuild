# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jam/jam-2.5-r3.ebuild,v 1.10 2007/11/24 16:13:04 grobian Exp $

inherit eutils flag-o-matic

DESCRIPTION="Just Another Make - advanced make replacement"
HOMEPAGE="http://www.perforce.com/jam/jam.html"
SRC_URI="ftp://ftp.perforce.com/pub/jam/${P}.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-devel/bison
		!dev-util/ftjam"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cxx.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
	epatch "${FILESDIR}"/${P}-dependency.patch
}

src_compile() {

	# Temporary work-around for bug #173703
	append-flags -fno-strict-aliasing

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
