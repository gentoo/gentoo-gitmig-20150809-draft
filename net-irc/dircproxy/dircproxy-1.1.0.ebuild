# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.1.0.ebuild,v 1.5 2004/07/30 20:31:51 vapier Exp $

inherit gnuconfig

DESCRIPTION="an IRC proxy server"
HOMEPAGE="http://dircproxy.securiweb.net/"
SRC_URI="http://www.securiweb.net/pub/oss/dircproxy/unstable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO INSTALL
}
