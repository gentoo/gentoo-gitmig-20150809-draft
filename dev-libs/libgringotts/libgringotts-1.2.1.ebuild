# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgringotts/libgringotts-1.2.1.ebuild,v 1.9 2004/11/22 18:06:16 leonardop Exp $

DESCRIPTION="Needed by Gringotts"
HOMEPAGE="http://devel.pluto.linux.it/projects/libGringotts/index.php"
SRC_URI="http://devel.pluto.linux.it/projects/libGringotts/current/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/libmcrypt-2.4.21
	>=app-crypt/mhash-0.8.13
	app-arch/bzip2
	sys-apps/coreutils
	sys-libs/zlib
	>=dev-util/pkgconfig-0.12.0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
