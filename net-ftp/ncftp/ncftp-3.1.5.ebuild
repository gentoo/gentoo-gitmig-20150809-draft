# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.5.ebuild,v 1.6 2003/02/14 13:20:17 gmsoft Exp $


S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2"
HOMEPAGE="http://www.ncftp.com/"

SLOT="0"
LICENSE="Clarified-Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa"

DEPEND=">=sys-libs/ncurses-5.2"

src_install() {
	dodir /usr/share
	einstall || die

	dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
	dodoc READLINE-README README WHATSNEW-3.0
}
