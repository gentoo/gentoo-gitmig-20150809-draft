# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sshfs-fuse/sshfs-fuse-1.0.ebuild,v 1.1 2005/01/15 19:34:55 genstef Exp $

DESCRIPTION="Fuse-filesystem utilizing the sftp service."
SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
HOMEPAGE="http://fuse.sourceforge.net/"
LICENSE="GPL-2"
DEPEND=">=sys-fs/fuse-2.2_pre3"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README NEWS ChangeLog AUTHORS
}
