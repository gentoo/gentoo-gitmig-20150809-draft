# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qmamecat/qmamecat-0.44.45.ebuild,v 1.2 2003/06/21 10:05:55 vapier Exp $

MY_PV="${PV/45/b45}"
DESCRIPTION="QT mame catalog and frontend"
SRC_URI="http://www.mameworld.net/mamecat/snapshots/qmamecat-${MY_PV}.tar.bz2"
HOMEPAGE="http://www.mameworld.net/mamecat/"

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
