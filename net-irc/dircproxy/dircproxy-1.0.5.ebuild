# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.0.5.ebuild,v 1.4 2003/06/16 17:35:34 vapier Exp $

DESCRIPTION="an IRC proxy server"
SRC_URI="http://www.dircproxy.net/download/stable/${P}.tar.gz"
HOMEPAGE="http://www.dircproxy.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND="virtual/glibc"

src_install() {
	make DESTDIR=${D} install-strip || die
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* TODO
}
