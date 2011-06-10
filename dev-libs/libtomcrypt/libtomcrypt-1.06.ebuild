# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-1.06.ebuild,v 1.8 2011/06/10 01:16:36 radhermit Exp $

inherit eutils flag-o-matic

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtomcrypt.org/"
SRC_URI="http://libtomcrypt.org/files/crypt-${PV}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc libtommath tomsfastmath"

RDEPEND="libtommath? ( dev-libs/libtommath )
	tomsfastmath? ( dev-libs/tomsfastmath )
	!libtommath? ( !tomsfastmath? ( dev-libs/libtommath ) )"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base app-text/ghostscript-gpl )"

src_unpack() {
	unpack crypt-${PV}.tar.bz2
	cd "${S}"
	epatch "${FILESDIR}"/libtomcrypt-1.06-makefile{,.shared}.diff
	use doc || sed -i '/^install:/s:docs::' makefile
}

src_compile() {
	use libtommath && append-flags -DLTM_DESC
	use tomsfastmath && append-flags -DTFM_DESC
	emake IGNORE_SPEED=1 || die
}

src_test() {
	# Tests don't compile
	true
}

src_install() {
	make DESTDIR="${D}" DATAPATH="/usr/share/doc/${P}" install || die
	dodoc TODO changes
	if use doc ; then
		dodoc doc/*
		docinto notes ; dodoc notes/*
		docinto demos ; dodoc demos/*
	fi
}
