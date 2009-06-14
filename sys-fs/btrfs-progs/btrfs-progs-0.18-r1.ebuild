# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-0.18-r1.ebuild,v 1.1 2009/06/14 15:46:16 lavajoe Exp $

inherit eutils

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl debug-utils"

DEPEND="debug-utils? ( dev-python/matplotlib )
	acl? (
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
	dosbin btrfsctl
	dosbin btrfsck
	dosbin btrfstune
	dosbin btrfs-image
	# fsck will segfault if invoked at boot, so do not make this link
	#dosym btrfsck /sbin/fsck.btrfs
	newsbin mkfs.btrfs mkbtrfs
	dosym mkbtrfs /sbin/mkfs.btrfs
	if use acl; then
		dosbin btrfs-convert
	else
		ewarn "Note: btrfs-convert not built/installed (requires acl USE flag)"
	fi

	if use debug-utils; then
		newsbin debug-tree btrfs-debug-tree
	else
		ewarn "Note: btrfs-debug-tree not installed (requires debug-utils USE flag)"
	fi

	into /usr
	newbin bcp btrfs-bcp

	if use debug-utils; then
		newbin show-blocks btrfs-show-blocks
	else
		ewarn "Note: btrfs-show-blocks not installed (requires debug-utils USE flag)"
	fi

	dodoc INSTALL
}

pkg_postinst() {
	ewarn "WARNING: This version of btrfs-progs corresponds to and should only"
	ewarn "         be used with the version of btrfs included in the"
	ewarn "         Linux kernel (2.6.29-rc2 and above)."
	ewarn ""
	ewarn "         This version should NOT be used with earlier versions"
	ewarn "         of the standaline btrfs module!"
}
