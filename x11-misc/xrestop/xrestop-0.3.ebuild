# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrestop/xrestop-0.3.ebuild,v 1.3 2005/06/14 12:18:05 smithj Exp $

IUSE=""

DESCRIPTION="'Top' like statistics of X11 client's server side resource usage"
SRC_URI="http://www.freedesktop.org/Software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fxrestop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

RDEPEND="virtual/x11"

src_install () {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL  NEWS README COPYING
}
