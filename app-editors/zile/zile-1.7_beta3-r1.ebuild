# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-1.7_beta3-r1.ebuild,v 1.3 2004/10/23 10:24:40 usata Exp $

inherit eutils

MY_P="${P/_beta/-b}"
DESCRIPTION="tiny emacs clone"
HOMEPAGE="http://zile.sourceforge.net/"
SRC_URI="mirror://sourceforge/zile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha -ppc ~amd64"
IUSE="doc"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND=">=dev-util/gperf-2.7.2
	>=sys-apps/texinfo-4.3
	doc? ( virtual/tetex )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-compilefix.diff"
	use doc || epatch "${FILESDIR}/${P}-norefcardps.diff"
}

src_compile() {
	myconf="--enable-all-modes"
	econf ${myconf} || die
	make || die
}

src_install() {
	dodir /usr/share/man
	dodir /usr/share/info
	keepdir /var/lib/{exrecover,expreserve}
	make INSTALL=/usr/bin/install \
		DESTDIR=${D} \
		MANDIR=/usr/share/man \
		TERMLIB=termlib \
		PRESERVEDIR=${D}/var/lib/expreserve \
		RECOVER="-DEXRECOVER=\\\"/var/lib/exrecover\\\" \
			-DEXPRESERVE=\\\"/var/lib/expreserve\\\"" \
		install || die

	dodoc AUTHORS HISTORY KNOWNBUGS NEWS README* TODO
}
