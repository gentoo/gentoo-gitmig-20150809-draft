# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://arg0.net/users/vgough/download/${P}-1.tgz"
HOMEPAGE="http://arg0.net/users/vgough/encfs.html"
LICENSE="GPL-2"
RDEPEND=">=dev-libs/openssl-0.9.7
		>=sys-fs/fuse-1.1
		dev-libs/rlog"
DEPEND="${RDEPEND}"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_install() {
	dodoc AUTHORS COPYING ChangeLog INSTALL README
	make DESTDIR=${D} install
}
