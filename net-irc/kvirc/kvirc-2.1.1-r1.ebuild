# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-2.1.1-r1.ebuild,v 1.13 2003/09/10 04:56:48 msterret Exp $

use kde && inherit kde-base

DESCRIPTION="A IRC Client for KDE"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI="ftp://ftp.kvirc.net/kvirc/2.1.1/source/${P}.tar.bz2"

LICENSE="kvirc"
SLOT="2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	=x11-libs/qt-2.3*"
use kde && need-kde 2.1

src_compile() {
	use kde && myconf="${myconf} --with-kde-support"
	use kde && kde_src_compile myconf

	./configure \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} \
		--prefix=/usr || die
	make kvirc || die
}

src_install() {
	make install DESTDIR=${D} || die
	make docs DESTDIR=${D} || die

	rm -rf ${D}/${KDEDIR}/man
	doman data/man/kvirc.1

	dodoc ChangeLog INSTALL README TODO
}
