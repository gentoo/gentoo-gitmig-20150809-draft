# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.4.6.ebuild,v 1.1 2003/01/31 15:53:09 ykoehler Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Aegypten development library"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/aegypten/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=""
RDEPEND=""

src_install(){
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README README-alpha THANKS TODO VERSION
}
