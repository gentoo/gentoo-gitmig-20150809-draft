# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-9999.ebuild,v 1.2 2008/06/09 18:03:52 lavajoe Exp $

inherit eutils mercurial

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="~sys-fs/btrfs-${PV}"

S="${WORKDIR}/progs-unstable"

src_unpack() {
	mercurial_fetch http://www.kernel.org/hg/btrfs/progs-unstable
	cd "${S}"
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
