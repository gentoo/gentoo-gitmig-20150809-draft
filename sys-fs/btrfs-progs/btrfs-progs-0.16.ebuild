# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-0.16.ebuild,v 1.1 2008/08/06 04:05:53 lavajoe Exp $

inherit eutils

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/e2fsprogs"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply hot fixes
	#epatch "${FILESDIR}/${P}-hotfix.patch"
}

src_install() {
	into /
	dosbin btrfs-show
	dosbin btrfs-vol
	dosbin btrfsctl
	dosbin btrfsck
	# fsck will segfault if invoked at boot, so do not make this link
	#dosym btrfsck /sbin/fsck.btrfs
	newsbin debug-tree btrfs-debug-tree
	newsbin mkfs.btrfs mkbtrfs
	dosym mkbtrfs /sbin/mkfs.btrfs

	# collides with boost
	#into /usr
	#dobin bcp

	dodoc INSTALL
}
