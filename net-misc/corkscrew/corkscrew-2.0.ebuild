# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/corkscrew/corkscrew-2.0.ebuild,v 1.8 2007/01/21 20:55:04 betelgeuse Exp $

DESCRIPTION="Corkscrew is a tool for tunneling SSH through HTTP proxies."
HOMEPAGE="http://www.agroman.net/corkscrew/"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
SRC_URI="http://www.agroman.net/corkscrew/${P}.tar.gz"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README TODO || die
}
