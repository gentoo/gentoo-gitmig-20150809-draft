# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-1.6.ebuild,v 1.2 2005/07/03 12:05:58 dholm Exp $

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
SRC_URI="http://onion.dynserv.net/~timo/files/${P}.tar.bz2"
HOMEPAGE="http://onion.dynserv.net/~timo/?page=Projects/netwmpager"
SLOT="0"
IUSE=""

DEPEND="virtual/x11 virtual/xft"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

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
