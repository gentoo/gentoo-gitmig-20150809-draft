# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-1.17-r2.ebuild,v 1.1 2009/03/16 10:45:13 bangert Exp $

inherit eutils

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtom.org/?page=features&whatfile=crypt"
SRC_URI="http://libtom.org/files/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc libtommath tomsfastmath"

RDEPEND="libtommath? ( dev-libs/libtommath )
	tomsfastmath? ( dev-libs/tomsfastmath )
	!libtommath? ( !tomsfastmath? ( dev-libs/libtommath ) )"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base virtual/ghostscript )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use doc || sed -i '/^install:/s:docs::' makefile
	epatch "${FILESDIR}"/libtomcrypt-1.17-r2-libtool-tag-and-make-fix.patch
}

src_compile() {
	use libtommath && append-flags -DLTM_DESC
	use tomsfastmath && append-flags -DTFM_DESC
	emake -f makefile.shared IGNORE_SPEED=1 || die "emake failed"
}

src_install() {
	#jobserver unavailable
	make -f makefile.shared DESTDIR="${D}" install ||\
		die "make install failed"
	dodoc TODO changes
	if use doc ; then
		dodoc doc/*
		docinto notes ; dodoc notes/*
		docinto demos ; dodoc demos/*
	fi
}
