# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-0.7.2-r1.ebuild,v 1.1 2002/05/27 01:24:18 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console ftp client with a lot of nifty features"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/yafc/yafc-0.7.2.tar.bz2"
HOMEPAGE="http://yafc.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="readline? ( >=sys-libs/readline-4.1-r4 )"

use readline || myconf="--without-readline"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}

