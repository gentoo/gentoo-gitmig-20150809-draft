# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.6_rc1.ebuild,v 1.2 2005/04/01 15:11:15 agriffis Exp $

IUSE="ssl ncurses zlib python spell"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
HOMEPAGE="http://dev.null.pl/ekg/"
SRC_URI="http://dev.null.pl/ekg/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~mips ia64 ~amd64"

S="${WORKDIR}/${P/_/}"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	!ncurses? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )
	spell? ( >=app-text/aspell-0.50.3 )"

src_compile() {
	local myconf="--enable-ioctld --enable-shared --with-pthread --enable-dynamic"
	use ssl     || myconf="$myconf --disable-openssl"
	use ncurses || myconf="$myconf --disable-ui-ncurses --enable-ui-readline"
	use zlib    || myconf="$myconf --disable-zlib"
	use python  && myconf="$myconf --with-python"
	use spell   && myconf="$myconf --enable-aspell"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc docs/* docs/api/*
}
