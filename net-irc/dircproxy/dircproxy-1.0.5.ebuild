# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.0.5.ebuild,v 1.11 2005/01/07 01:08:33 swegener Exp $

DESCRIPTION="an IRC proxy server"
SRC_URI="http://www.securiweb.net/pub/oss/dircproxy/stable/${P}.tar.gz"
HOMEPAGE="http://dircproxy.securiweb.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO INSTALL
}
