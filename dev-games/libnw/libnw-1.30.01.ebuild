# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libnw/libnw-1.30.01.ebuild,v 1.4 2004/04/19 12:22:53 wolf31o2 Exp $

DESCRIPTION="Tools and libraries for NWN file manipulation"
HOMEPAGE="http://openknights.sourceforge.net/"
SRC_URI="mirror://sourceforge/openknights/${P}.tar.gz"

LICENSE="openknights"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.License-Torlack README.tech TODO
}
