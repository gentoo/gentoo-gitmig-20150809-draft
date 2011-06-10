# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-1.17-r3.ebuild,v 1.4 2011/06/10 01:16:36 radhermit Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtom.org/?page=features&whatfile=crypt"
SRC_URI="http://libtom.org/files/crypt-${PV}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc libtommath tomsfastmath"

RDEPEND="libtommath? ( dev-libs/libtommath )
	tomsfastmath? ( >=dev-libs/tomsfastmath-0.12 )
	!libtommath? ( !tomsfastmath? ( dev-libs/libtommath ) )"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base app-text/ghostscript-gpl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use doc || sed -i '/^install:/s:docs::' makefile
	epatch "${FILESDIR}"/libtomcrypt-1.17-r2-libtool-tag-and-make-fix.patch
}

src_compile() {
	local extraflags=""
	use libtommath && append-flags -DLTM_DESC && extraflags="-ltommath"
	use tomsfastmath && append-flags -DTFM_DESC && extraflags="${extraflags} -ltfm"
	sed -i -e "s:gcc:$(tc-getCC):g" \
		-e "s:--mode=link gcc:--mode=link $(tc-getCC) --tag CC $(tc-getCC):g" \
		{,testprof/}makefile.shared
	EXTRALIBS="${extraflags}" emake -f makefile.shared IGNORE_SPEED=1 || die "emake failed"
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
