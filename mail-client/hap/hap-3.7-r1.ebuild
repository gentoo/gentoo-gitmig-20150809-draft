# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/hap/hap-3.7-r1.ebuild,v 1.6 2012/04/25 16:26:15 jlec Exp $

EAPI=2

inherit autotools

DESCRIPTION="A terminal mail notification program (replacement for biff)"
HOMEPAGE="http://www.transbay.net/~enf/sw.html"
SRC_URI="http://www.transbay.net/~enf/${P}.tar"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	# Fix configure to use ncurses instead of termcap (bug #103105)
	sed -i -e '/AC_CHECK_LIB/s~termcap~ncurses~' configure.in

	# Fix Makefile.in to use our CFLAGS and LDFLAGS
	sed -i -e "s/^CFLAGS=-O/CFLAGS=${CFLAGS}/" \
		-e "s/^LDFLAGS=.*/LDFLAGS=${LDFLAGS}/" Makefile.in

	# Rebuild the compilation framework
	eautoreconf
}

src_install() {
	dobin hap || die
	doman hap.1 || die
	dodoc README HISTORY || die
}
