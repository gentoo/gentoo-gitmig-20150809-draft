# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.5.ebuild,v 1.3 2002/12/15 11:58:45 bjb Exp $


S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2"
HOMEPAGE="http://www.ncftp.com/"

SLOT="0"
LICENSE="Clarified-Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=sys-libs/ncurses-5.2"

src_install() {
	dodir /usr/share
	einstall || die

	dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
	dodoc READLINE-README README WHATSNEW-3.0
}
