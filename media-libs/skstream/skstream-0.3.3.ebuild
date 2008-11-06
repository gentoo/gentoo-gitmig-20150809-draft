# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.3.3.ebuild,v 1.6 2008/11/06 20:25:46 tupone Exp $

DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~ppc sparc x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install died"
	rm "${D}"/usr/share/doc/${PF}/COPYING
	dodoc TODO
}
