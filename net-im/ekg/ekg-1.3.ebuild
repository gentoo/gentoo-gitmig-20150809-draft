# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.3.ebuild,v 1.4 2004/01/21 22:57:20 spock Exp $

IUSE="ssl ncurses zlib python readline"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
SRC_URI="http://dev.null.pl/ekg/${P}.tar.gz"
HOMEPAGE="http://dev.null.pl/ekg/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	!ncurses? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )"

src_compile() {

	local myconf=""
	use ssl     || myconf="$myconf --disable-openssl"
	use ncurses || myconf="$myconf --disable-ui-ncurses --enable-ui-readline"
	use zlib    || myconf="$myconf --disable-zlib"

	econf ${myconf} || die
	emake || die

}

src_install() {

	einstall || die
	dodoc docs/*
}
