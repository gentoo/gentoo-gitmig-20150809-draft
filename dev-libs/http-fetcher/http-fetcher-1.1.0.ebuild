# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/http-fetcher/http-fetcher-1.1.0.ebuild,v 1.1 2005/02/11 11:39:29 ka0ttic Exp $

MY_P="${P/-/_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="HTTP Fetcher is a small, robust, flexible library for downloading files via HTTP using the GET method."
HOMEPAGE="http://http-fetcher.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc"
IUSE="debug"

RDEPEND="virtual/libc"

src_compile() {
	econf --enable-strict $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dohtml -r docs/index.html docs/html
	dodoc README ChangeLog CREDITS INSTALL LICENSE
}
