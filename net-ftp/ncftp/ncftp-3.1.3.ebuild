# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.3.ebuild,v 1.1 2002/06/19 18:58:51 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2"
HOMEPAGE="http://www.ncftp.com/"
SLOT="0"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"
LICENSE="Clarified-Artistic"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} \
		--mandir=/usr/share/man || die
	
	emake || die
}

src_install() {
	dodir /usr/share
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
	dodoc READLINE-README README WHATSNEW-3.0
}
