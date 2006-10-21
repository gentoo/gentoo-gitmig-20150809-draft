# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.5.0.ebuild,v 1.2 2006/10/21 23:06:15 dev-zero Exp $

DESCRIPTION="classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's|^\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS

	if use doc ; then
		# installed by dvutil
		rm -f doc/man/*/{Dv,tostring.h}.3

		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
