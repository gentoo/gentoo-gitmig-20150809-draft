# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.1.0-r1.ebuild,v 1.1 2005/01/07 01:08:33 swegener Exp $

inherit eutils

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

	epatch ${FILESDIR}/${PV}-005-numeric.patch
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO INSTALL
}
