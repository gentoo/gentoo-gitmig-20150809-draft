# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gnomevfs-mount/gnomevfs-mount-0.2.0.ebuild,v 1.1 2005/03/10 15:24:07 genstef Exp $

DESCRIPTION="A program for mounting gnome-vfs-uris onto the linux filesystem."
HOMEPAGE="http://primates.ximian.com/~sandino/gnomevfs-mount/"
SRC_URI="http://primates.ximian.com/~sandino/gnomevfs-mount/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.2
	>=gnome-base/gnome-vfs-2.6.1.1"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README
}
