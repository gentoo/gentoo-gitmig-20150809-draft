# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgringotts/libgringotts-1.1.2.ebuild,v 1.5 2003/11/14 20:05:55 seemant Exp $

DESCRIPTION="libgringotts - Needed by Gringotts"
SRC_URI="http://devel.pluto.linux.it/projects/libGringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/libGringotts/index.php"
S=${WORKDIR}/${P}
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-libs/libmcrypt-2.4.21
	>=app-crypt/mhash-0.8.13
	app-arch/bzip2
	sys-apps/textutils
	sys-libs/zlib
	>=dev-util/pkgconfig-0.12.0"

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog COPYING README TODO
}
