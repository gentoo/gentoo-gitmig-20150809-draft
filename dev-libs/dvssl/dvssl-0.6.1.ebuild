# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.6.1.ebuild,v 1.1 2009/04/25 21:31:06 patrick Exp $

DESCRIPTION="Provides a simple interface to OpenSSL"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="dev-libs/openssl
	dev-libs/dvnet
	dev-libs/dvutil"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's|^\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
