# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs/btrfs-0.15-r1.ebuild,v 1.1 2008/06/07 16:38:35 lavajoe Exp $

inherit eutils linux-mod

DESCRIPTION="A checksumming copy-on-write filesystem"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/e2fsprogs"
PDEPEND="~sys-fs/btrfs-progs-${PV}"

pkg_setup()
{
	linux-mod_pkg_setup

	BUILD_TARGETS="all"
	BUILD_PARAMS="KERNELDIR=/lib/modules/${KV_FULL}/build"
	MODULE_NAMES="btrfs(fs:${S}/"

	if ! kernel_is 2 6; then
		eerror "Need a 2.6 kernel to compile against!"
		die "Need a 2.6 kernel to compile against!"
	fi

	if ! linux_chkconfig_present LIBCRC32C; then
		eerror "You need to enable LIBCRC32C in your kernel!"
		die "You need to enable LIBCRC32C in your kernel!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-acl-disable.patch"
}

src_install()
{
	linux-mod_src_install

	dodoc INSTALL TODO
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "WARNING: Btrfs is under heavy development and is not suitable for"
	ewarn "any uses other than benchmarking and review."
	ewarn "The Btrfs disk format is not yet finalized."
	ewarn ""
	ewarn "Note: If upgrading from 0.14, there is no disk format change,"
	ewarn "      but it might be prudent to fsck after upgrading."
}
