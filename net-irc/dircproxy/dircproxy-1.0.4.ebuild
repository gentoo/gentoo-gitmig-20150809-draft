# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.0.4.ebuild,v 1.1 2002/11/05 19:29:05 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an IRC proxy server"
SRC_URI="http://www.dircproxy.net/download/stable/${P}.tar.gz"
HOMEPAGE="http://www.dircproxy.net/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_install () {
	make DESTDIR=${D} install-strip || die

	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO
}
