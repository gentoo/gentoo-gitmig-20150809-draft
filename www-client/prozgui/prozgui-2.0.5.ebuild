# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/prozgui/prozgui-2.0.5.ebuild,v 1.1 2005/03/15 21:49:08 seemant Exp $

inherit eutils

DESCRIPTION="A Graphical download manager"
HOMEPAGE="http://prozilla.genesys.ro/"
SRC_URI="http://prozilla.genesys.ro/downloads/${PN}/tarballs/${P}beta.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=x11-libs/fltk-1.1"

S="${WORKDIR}/${P}beta"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-options.patch
}

src_compile() {
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--sysconfdir=/etc \
		--disable-nls \
		--with-fltk-includes=`fltk-config --cflags | cut -d' ' -f1 | sed 's/-I//'` \
		--with-fltk-libs=`fltk-config --ldflags | cut -d' ' -f1 | sed 's/-L//'` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} \
		sysconfdir=${D}/etc \
		install || die

	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
