# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs/btrfs-0.17.ebuild,v 1.1 2009/04/17 15:16:51 lavajoe Exp $

inherit eutils linux-mod

DESCRIPTION="A checksumming copy-on-write filesystem"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup()
{
	linux-mod_pkg_setup

	BUILD_TARGETS="all"
	BUILD_PARAMS="KERNELDIR=${KV_OUT_DIR}"
	MODULE_NAMES="btrfs(fs:${S})"

	if ! kernel_is 2 6; then
		eerror "Need a 2.6 kernel to compile against!"
		die "Need a 2.6 kernel to compile against!"
	fi

	if kernel_is lt 2 6 28; then
		eerror "Not compatible with kernels earlier than 2.6.28."
		die "Not compatible with kernels earlier than 2.6.28."
	fi

	if ! linux_chkconfig_present LIBCRC32C; then
		eerror "You need to enable LIBCRC32C in your kernel!"
		die "You need to enable LIBCRC32C in your kernel!"
	fi

	if ! linux_chkconfig_present ZLIB_INFLATE; then
		eerror "You need to enable ZLIB_INFLATE in your kernel!"
		die "You need to enable ZLIB_INFLATE in your kernel!"
	fi

	if ! linux_chkconfig_present ZLIB_DEFLATE; then
		eerror "You need to enable ZLIB_DEFLATE in your kernel!"
		die "You need to enable ZLIB_DEFLATE in your kernel!"
	fi

}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "WARNING: Btrfs is under heavy development and is not suitable for"
	ewarn "         any uses other than benchmarking and review."
	ewarn "         The Btrfs disk format is not yet finalized."
	ewarn
	ewarn "         Also, it is highly recommended that the versions of"
	ewarn "         btrfs and btrfs-progs match."
	ewarn
	ewarn "Note: THE DISK FORMAT HAS CHANGED!"
	ewarn "      You must backup your data and re-create your btrfs"
	ewarn "      filesystem(s) for use with this version."
}
