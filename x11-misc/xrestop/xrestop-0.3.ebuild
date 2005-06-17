# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrestop/xrestop-0.3.ebuild,v 1.4 2005/06/17 20:20:13 hansmi Exp $

IUSE=""

DESCRIPTION="'Top' like statistics of X11 client's server side resource usage"
SRC_URI="http://www.freedesktop.org/Software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fxrestop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

RDEPEND="virtual/x11"

src_install () {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL  NEWS README COPYING
}
