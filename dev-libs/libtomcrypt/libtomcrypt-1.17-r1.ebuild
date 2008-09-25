# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-1.17-r1.ebuild,v 1.1 2008/09/25 16:09:39 hawking Exp $

inherit flag-o-matic

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
}

src_compile() {
	use libtommath && append-flags -DLTM_DESC
	use tomsfastmath && append-flags -DTFM_DESC
	emake -f makefile.shared IGNORE_SPEED=1 || die "emake failed"
}

src_install() {
	emake -f makefile.shared DESTDIR="${D}" install ||\
		die "emake install failed"
	dodoc TODO changes || die "dodoc failed"
	if use doc ; then
		dodoc doc/* || die "dodoc failed"
		docinto notes ; dodoc notes/* || die "dodoc failed"
		docinto demos ; dodoc demos/* || die "dodoc failed"
	fi
}
