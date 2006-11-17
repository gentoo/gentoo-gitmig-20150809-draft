# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-1.11.ebuild,v 1.1 2006/11/17 19:37:48 omp Exp $

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
HOMEPAGE="http://onion.dynserv.net/~timo/netwmpager.html"
SRC_URI="http://onion.dynserv.net/~timo/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libXdmcp
	x11-libs/libXau"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	virtual/xft
	x11-proto/xproto"

src_compile() {
	# econf does not work.
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc config-example README

	# Don't install duplicate ungzipped config-example.
	rm -rf "${D}/usr/share/netwmpager/"
}
