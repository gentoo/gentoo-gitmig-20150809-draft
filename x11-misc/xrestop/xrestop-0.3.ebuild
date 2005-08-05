# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrestop/xrestop-0.3.ebuild,v 1.6 2005/08/05 13:05:47 ferdy Exp $

IUSE=""

DESCRIPTION="'Top' like statistics of X11 client's server side resource usage"
SRC_URI="http://www.freedesktop.org/Software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fxrestop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86"

RDEPEND="virtual/x11"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL  NEWS README COPYING
}
