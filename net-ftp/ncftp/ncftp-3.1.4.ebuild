# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.4.ebuild,v 1.6 2002/12/09 04:33:12 manson Exp $


S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2"
HOMEPAGE="http://www.ncftp.com/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="Clarified-Artistic"
KEYWORDS="x86 ppc sparc "

src_compile() {

	econf || die
	emake || die
}

src_install() {
	dodir /usr/share
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
	dodoc READLINE-README README WHATSNEW-3.0
}
