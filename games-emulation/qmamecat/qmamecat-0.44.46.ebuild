# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/qmamecat/qmamecat-0.44.46.ebuild,v 1.5 2005/07/28 21:04:50 caleb Exp $

inherit kde

MY_PV="${PV/46/b46}"
DESCRIPTION="QT mame catalog and frontend"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="http://www.mameworld.net/mamecat/snapshots/qmamecat-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/x11
	=x11-libs/qt-3*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #89926 - we lub magic numbers
	sed -i \
		-e 's/5000/6000/' \
		-e 's/101/120/' \
		src/include/macros.hxx \
		|| die "sed failed"
}

src_compile() {
	# See bug #41006
	kde_src_compile none

	emake -j1 COPTIM="${CFLAGS}" || die "emake failed"
}

src_install() {
	rm bin/{Makefile,make.cfg}
	dobin bin/*
	doman doc/*.6
	rm doc/{*.6,COPYING}
	dodoc doc/*
}
