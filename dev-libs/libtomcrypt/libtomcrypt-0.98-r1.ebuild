# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-0.98-r1.ebuild,v 1.2 2004/08/27 23:44:49 kugelfang Exp $

inherit eutils

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtomcrypt.org/"
SRC_URI="http://libtomcrypt.org/files/crypt-${PV}.tar.bz2
	http://libtomcrypt.org/files/patch-${PV}/ltc-${PV}-001.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="doc"

DEPEND="doc? ( virtual/tetex app-text/ghostscript )"

src_unpack() {
	unpack crypt-${PV}.tar.bz2
	mkdir patches && cd patches
	unpack ltc-${PV}-001.tar.bz2
	cd ${S}
	epatch $(find ${WORKDIR}/patches -type f)
	use doc || sed -i '/^install:/s:docs::' makefile
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc authors changes
	if use doc ; then
		docinto examples ; dodoc examples/*
		docinto notes ; dodoc notes/*
		docinto demos ; dodoc demos/*
	fi
}
