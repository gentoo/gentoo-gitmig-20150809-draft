# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-plugger/netscape-plugger-5.0.ebuild,v 1.1 2003/10/31 23:33:01 lu_zero Exp $

MY_P=${P/netscape-/}
DESCRIPTION="Plugger streaming media plugin"
SRC_URI="http://fredrik.hubbe.net/plugger/${MY_P}.tar.gz"
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SLOT="0"
DEPEND="net-www/mozilla"
KEYWORDS="~x86 ~ppc ~sparc "
LICENSE="GPL-2"
S=${WORKDIR}/${MY_P}

src_compile () {
	emake linux || die
}

src_install () {
	dodir /etc
	make root=${D} prefix="/usr" install || die

}
