# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs/zfs-9999.ebuild,v 1.6 2012/02/04 21:06:23 floppym Exp $

EAPI="4"

inherit git-2 linux-mod autotools-utils

DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zfsonlinux/zfs.git"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

DEPEND=">=sys-kernel/spl-${PV}"
RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

pkg_setup() {
	CONFIG_CHECK="!PREEMPT !DEBUG_LOCK_ALLOC"
	kernel_is ge 2 6 32 || die "Linux 2.6.32 or newer required"
	check_extra_config
}

src_configure() {
	set_arch_to_kernel
	local myeconfargs=(
		--exec-prefix=
		--with-config=all
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		--with-udevdir=/lib/udev
	)
	autotools-utils_src_configure
}
