# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/qmamecat/qmamecat-0.44.45.ebuild,v 1.2 2004/02/20 06:26:48 mr_bones_ Exp $

MY_PV="${PV/45/b45}"
DESCRIPTION="QT mame catalog and frontend"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="http://www.mameworld.net/mamecat/snapshots/qmamecat-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	virtual/x11
	x11-libs/qt"

S=${WORKDIR}/${PN}

src_compile() {
	# emake is horribly broken
	make COPTIM="${CFLAGS}" || die
}

src_install() {
	rm bin/{Makefile,make.cfg}
	dobin bin/*
	doman doc/*.6
	rm doc/*.6
	dodoc doc/*
}
