# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mlton-bin/mlton-bin-20040227.ebuild,v 1.4 2004/07/02 04:28:42 eradicator Exp $

inherit eutils

DESCRIPTION="Standard ML optimizing compiler and libraries"
SRC_URI="http://www.mlton.org/download/mlton-${PV}-1.i386-linux.tgz"
HOMEPAGE="http://www.mlton.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"

IUSE="doc"

DEPEND="virtual/libc
dev-libs/gmp"

src_install() {
	cd ${WORKDIR}/usr
	dobin bin/*

	insinto /usr/lib/mlton

	cp -Rp lib/mlton/* ${D}/usr/lib/mlton

	doman man/man1/*.1.gz

	cd share/doc/mlton
	dodoc changelog README
	dodoc license/*

	if use doc; then
		cp -R cmcat examples ${D}/usr/share/doc/${P}/
		dohtml user-guide/*
		dodoc *.ps.gz
	fi
}
