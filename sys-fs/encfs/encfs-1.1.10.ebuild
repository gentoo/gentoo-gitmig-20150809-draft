# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.1.10.ebuild,v 1.3 2005/01/08 11:14:14 swegener Exp $

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://arg0.net/users/vgough/download/${P}-1.tgz"
HOMEPAGE="http://arg0.net/users/vgough/encfs.html"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
	<sys-fs/fuse-1.9
	dev-libs/rlog"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
