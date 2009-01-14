# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-0.17.ebuild,v 1.1 2009/01/14 22:12:04 lavajoe Exp $

inherit eutils

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl"

DEPEND="acl? (
			sys-apps/acl
			sys-fs/e2fsprogs
		)"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply hot fixes
	#epatch "${FILESDIR}/${P}-hotfix.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		all || die
	if use acl; then
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
			convert || die
	fi
}

src_install() {
	into /
	dosbin btrfs-show
	dosbin btrfs-vol
	dosbin btrfs-image
	dosbin btrfsctl
	dosbin btrfstune
	dosbin btrfsck
	# fsck will segfault if invoked at boot, so do not make this link
	#dosym btrfsck /sbin/fsck.btrfs
	#newsbin debug-tree btrfs-debug-tree
	newsbin mkfs.btrfs mkbtrfs
	dosym mkbtrfs /sbin/mkfs.btrfs
	if use acl; then
		dosbin btrfs-convert
	else
		ewarn "Note: btrfs-convert not built/installed (requires acl USE flag)"
	fi

	into /usr
	newbin bcp btrfs-bcp
	newbin show-blocks btrfs-show-blocks

	dodoc INSTALL
}
