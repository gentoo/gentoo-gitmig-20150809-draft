# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-0.7.9.ebuild,v 1.1 2002/06/06 19:20:55 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console ftp client with a lot of nifty features"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://yafc.sourceforge.net/"
DEPEND="virtual/glibc readline? ( >=sys-libs/readline-4.1-r4 )"
RDEPEND="${DEPEND} >=net-misc/openssh-3.0"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	use readline || myconf="--without-readline"
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
	dodoc ABOUT-NLS BUGS COPYING COPYRIGHT INSTALL NEWS \
		README THANKS TODO *.sample
}
