# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-1.7_alpha6.ebuild,v 1.2 2003/02/13 07:02:45 vapier Exp $

DESCRIPTION="Zile is a tiny emacs clone."
HOMEPAGE="http://zile.sourceforge.net/"
SRC_URI="mirror://sourceforge/zile/${P/_alpha/-a}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~ppc"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P/_alpha/-a}"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
	    --mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	dodir /usr/share/man
	keepdir /var/lib/{exrecover,expreserve}
	make INSTALL=/usr/bin/install \
		DESTDIR=${D} \
		infodir=${D}/usr/share/info\
		MANDIR=/usr/share/man \
		TERMLIB=termlib \
		PRESERVEDIR=${D}/var/lib/expreserve \
		RECOVER="-DEXRECOVER=\\\"/var/lib/exrecover\\\" \
			-DEXPRESERVE=\\\"/var/lib/expreserve\\\"" \
		install || die
	
	dodoc COPYRIGHT CREDITS HISTORY KNOWNBUGS NEWS README* TODO LICENSE
}

