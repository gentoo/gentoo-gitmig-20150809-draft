# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.1.0.ebuild,v 1.2 2004/06/17 10:28:41 swegener Exp $

DESCRIPTION="an IRC proxy server"
SRC_URI="http://www.securiweb.net/pub/oss/dircproxy/unstable/${P}.tar.gz"
HOMEPAGE="http://dircproxy.securiweb.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

DEPEND="virtual/glibc"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO INSTALL
}
