# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-1.7_beta3.ebuild,v 1.1 2004/05/22 15:48:53 usata Exp $

IUSE=""
MY_P="${P/_beta/-b}"

DESCRIPTION="tiny emacs clone"
HOMEPAGE="http://zile.sourceforge.net/"
SRC_URI="mirror://sourceforge/zile/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha -ppc"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND=">=dev-util/gperf-2.7.2
	>=sys-apps/texinfo-4.3"

S="${WORKDIR}/${MY_P}"

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

	dodoc AUTHORS COPYING HISTORY KNOWNBUGS NEWS README* TODO
}
