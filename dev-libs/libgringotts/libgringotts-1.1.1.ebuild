# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgringotts/libgringotts-1.1.1.ebuild,v 1.1 2002/12/06 03:27:15 leonardop Exp $

DESCRIPTION="libgringotts - Needed by Gringotts"
SRC_URI="http://devel.pluto.linux.it/projects/libGringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/libGringotts/index.php"
S=${WORKDIR}/${P}
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libmcrypt-2.4.21
	>=app-crypt/mhash-0.8.13
	sys-libs/zlib
	>=dev-util/pkgconfig-0.12.0
	x11-base/xfree"

src_compile() {
	econf || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog COPYING README TODO
}
