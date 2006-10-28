# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-1.6.ebuild,v 1.5 2006/10/28 22:30:39 omp Exp $

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
HOMEPAGE="http://onion.dynserv.net/~timo/?page=Projects/netwmpager"
SRC_URI="http://onion.dynserv.net/~timo/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
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

src_compile()
{
	# econf doesn't work
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install ()
{
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README THANKS TODO
}
