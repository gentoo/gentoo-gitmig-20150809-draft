# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/http-fetcher/http-fetcher-1.1.0.ebuild,v 1.5 2006/02/06 19:44:32 blubb Exp $

MY_P="${P/-/_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="HTTP Fetcher is a small, robust, flexible library for downloading files via HTTP using the GET method."
HOMEPAGE="http://http-fetcher.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
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
