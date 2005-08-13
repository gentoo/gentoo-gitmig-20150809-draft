# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.5.4-r2.ebuild,v 1.3 2005/08/13 23:12:50 hansmi Exp $

inherit eutils

DESCRIPTION="dvssl provides a simple interface to openssl"
SRC_URI="http://tinfpc2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/html/"

KEYWORDS="ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

DEPEND="dev-libs/openssl
	dev-libs/dvnet"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fix-underquoted-m4.diff

	sed -i 's|^\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
