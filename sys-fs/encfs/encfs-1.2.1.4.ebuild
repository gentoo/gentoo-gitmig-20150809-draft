# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.2.1.4.ebuild,v 1.3 2005/07/29 12:07:57 swegener Exp $

inherit versionator

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://arg0.net/users/vgough/download/${PN}-$(replace_version_separator 3 '-').tgz"
HOMEPAGE="http://arg0.net/users/vgough/encfs.html"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
	>=sys-fs/fuse-2.2
	>=dev-libs/rlog-1.3.6"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
