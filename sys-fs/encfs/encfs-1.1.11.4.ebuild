# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.1.11.4.ebuild,v 1.1 2005/01/25 19:39:23 genstef Exp $

inherit versionator

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://arg0.net/users/vgough/download/${PN}-$(replace_version_separator 3 '-').tgz"
HOMEPAGE="http://arg0.net/users/vgough/encfs.html"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
	sys-fs/fuse
	dev-libs/rlog"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
