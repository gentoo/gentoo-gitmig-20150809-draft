# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-1.6.ebuild,v 1.4 2006/02/11 11:18:28 nelchael Exp $

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
SRC_URI="http://onion.dynserv.net/~timo/files/${P}.tar.bz2"
HOMEPAGE="http://onion.dynserv.net/~timo/?page=Projects/netwmpager"
SLOT="0"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXft
		x11-libs/libXdmcp
		x11-libs/libXau )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )
	virtual/xft"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

src_compile()
{
	# econf doesn't work
	./configure --prefix=/usr || die
	emake || die
}

src_install ()
{
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog README THANKS TODO
}
