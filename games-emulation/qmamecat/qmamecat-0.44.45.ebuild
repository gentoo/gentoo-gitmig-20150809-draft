# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/qmamecat/qmamecat-0.44.45.ebuild,v 1.5 2004/06/24 22:35:35 agriffis Exp $

inherit kde

MY_PV="${PV/45/b45}"
DESCRIPTION="QT mame catalog and frontend"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="http://www.mameworld.net/mamecat/snapshots/qmamecat-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/glibc
	virtual/x11
	x11-libs/qt"

S="${WORKDIR}/${PN}"

src_compile() {
	# See bug #41006
	kde_src_compile none

	# emake is horribly broken
	make COPTIM="${CFLAGS}" || die
}

src_install() {
	rm bin/{Makefile,make.cfg}
	dobin bin/*
	doman doc/*.6
	rm doc/{*.6,COPYING}
	dodoc doc/*
}
