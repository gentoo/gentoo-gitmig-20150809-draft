# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shhopt/shhopt-1.1.7-r1.ebuild,v 1.2 2007/01/25 14:49:24 beandog Exp $

DESCRIPTION="library for parsing command line options"
SRC_URI="http://shh.thathost.com/pub-unix/files/${P}.tar.gz"
HOMEPAGE="http://shh.thathost.com/pub-unix/"
LICENSE="Artistic"
DEPEND=""
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_install () {
	dolib.a libshhopt.a
	insinto /usr/include
	doins shhopt.h
	dodoc ChangeLog CREDITS INSTALL README TODO
}
