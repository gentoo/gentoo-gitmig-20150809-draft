# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-1.00.ebuild,v 1.1 2005/03/17 00:07:27 vapier Exp $

inherit eutils

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtomcrypt.org/"
SRC_URI="http://libtomcrypt.org/files/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( virtual/tetex app-text/ghostscript )"
RDEPEND=""

src_unpack() {
	unpack crypt-${PV}.tar.bz2
	cd "${S}"
	use doc || sed -i '/^install:/s:docs::' makefile
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc authors changes
	if use doc ; then
		docinto examples ; dodoc examples/*
		docinto notes ; dodoc notes/*
		docinto demos ; dodoc demos/*
	fi
}
