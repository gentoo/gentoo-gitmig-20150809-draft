# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/http-fetcher/http-fetcher-1.0.3.ebuild,v 1.2 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="HTTP Fetcher is a small, robust, flexible library for downloading files via HTTP using the GET method."
HOMEPAGE="http://http-fetcher.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/${P/-/_}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml -r docs/index.html docs/html
	dodoc README ChangeLog CREDITS INSTALL LICENSE
}
