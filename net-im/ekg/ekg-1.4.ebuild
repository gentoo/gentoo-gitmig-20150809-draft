# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.4.ebuild,v 1.2 2004/01/16 10:24:10 spock Exp $

IUSE="ssl ncurses zlib python"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
HOMEPAGE="http://dev.null.pl/ekg/"
SRC_URI="http://dev.null.pl/ekg/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~amd64"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	!ncurses? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )"

src_compile() {

	local myconf="--enable-ioctld --enable-shared --with-pthread --enable-dynamic"
	use ssl     || myconf="$myconf --disable-openssl"
	use ncurses || myconf="$myconf --disable-ui-ncurses --enable-ui-readline"
	use zlib    || myconf="$myconf --disable-zlib"
	use python  && myconf="$myconf --enable-python"

	econf ${myconf} || die
	emake || die

}

src_install() {

	einstall || die
	dodoc docs/* docs/api/*
}
