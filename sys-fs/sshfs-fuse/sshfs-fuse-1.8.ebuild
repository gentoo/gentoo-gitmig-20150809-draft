# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sshfs-fuse/sshfs-fuse-1.8.ebuild,v 1.5 2007/08/13 21:55:06 dertobi123 Exp $

inherit eutils

DESCRIPTION="Fuse-filesystem utilizing the sftp service."
SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
HOMEPAGE="http://fuse.sourceforge.net/sshfs.html"
LICENSE="GPL-2"
DEPEND=">=sys-fs/fuse-2.6.0_pre3
	>=dev-libs/glib-2.4.2"
RDEPEND="${DEPEND}
	>=net-misc/openssh-4.3"
KEYWORDS="amd64 ~hppa ppc ~ppc64 sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

src_compile() {
	# hack not needed with >=net-misc/openssh-4.3
	econf --disable-sshnodelay || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc README NEWS ChangeLog AUTHORS
}
