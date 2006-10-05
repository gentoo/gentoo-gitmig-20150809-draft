# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sshfs-fuse/sshfs-fuse-1.7.ebuild,v 1.3 2006/10/05 20:58:43 gustavoz Exp $

inherit eutils

DESCRIPTION="Fuse-filesystem utilizing the sftp service."
SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
HOMEPAGE="http://fuse.sourceforge.net/sshfs.html"
LICENSE="GPL-2"
DEPEND=">=sys-fs/fuse-2.6.0_pre3
	>=dev-libs/glib-2.4.2"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc README NEWS ChangeLog AUTHORS
}
