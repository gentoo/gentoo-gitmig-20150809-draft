# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnw/libnw-1.30.01.ebuild,v 1.1 2003/07/11 17:32:00 vapier Exp $

DESCRIPTION="Tools and libraries for NWN file manipulation"
HOMEPAGE="http://openknights.sf.net/"
SRC_URI="mirror://sourceforge/openknights/${P}.tar.gz"

SLOT="0"
LICENSE="openknights"
KEYWORDS="x86 ppc"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.License-Torlack README.tech TODO
}
