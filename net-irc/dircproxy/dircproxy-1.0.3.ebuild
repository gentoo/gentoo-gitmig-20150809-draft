# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.0.3.ebuild,v 1.4 2002/08/28 15:19:51 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an IRC proxy server"
SRC_URI="http://www.dircproxy.net/download/stable/${P}.tar.gz"
HOMEPAGE="http://www.dircproxy.net/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	econf || die "./configure failed"
	emake || die

}

src_install () {

	make DESTDIR=${D} install-strip || die

	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO
}
