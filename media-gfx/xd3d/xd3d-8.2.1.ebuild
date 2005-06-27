# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xd3d/xd3d-8.2.1.ebuild,v 1.2 2005/06/27 02:00:46 ribosome Exp $

DESCRIPTION="scientific visualization tool"

HOMEPAGE="http://www.cmap.polytechnique.fr/~jouve/xd3d/"
SRC_URI="http://www.cmap.polytechnique.fr/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="icc"

RDEPEND="virtual/x11 \
	icc? ( dev-lang/icc dev-lang/ifc )"

DEPEND="${RDEPEND}
	sys-apps/which
	app-shells/tcsh"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/gentoo-${P}.diff
}

src_compile() {
	if use icc; then
		sed "s:##D##:${D}:g" < RULES.icc > RULES.gentoo
	else
		which g77 2> /dev/null || die "No GNU Fortran compiler found!"
		sed "s:##CFLAGS##:${CFLAGS}:g" < RULES.gentoo > RULES.linux
		sed "s:##D##:${D}:g" < RULES.linux > RULES.gentoo
	fi
	./configure -arch=gentoo || die

	make || die
}

src_install() {
	make install || die

	dodoc BUGS CHANGELOG FAQ FORMATS INSTALL LICENSE README
	insinto /usr/share/doc/${PF}
	doins Manuals/*

	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins Examples/*
}
