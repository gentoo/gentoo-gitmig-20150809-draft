# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pure-sfv/pure-sfv-0.3.ebuild,v 1.14 2008/10/23 02:43:22 flameeyes Exp $

inherit toolchain-funcs

DESCRIPTION="utility to test and create .sfv files and create .par files"
HOMEPAGE="http://pure-sfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/pure-sfv/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE=""
RESTRICT="test"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-O2 -g::;s:-Werror::' Makefile
}

src_compile() {
	emake CC="$(tc_getCC)" || die "emake failed"
}

src_install() {
	dobin pure-sfv || die
	dodoc ReadMe.txt
}
