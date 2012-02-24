# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs/zfs-9999.ebuild,v 1.8 2012/02/24 22:46:23 floppym Exp $

EAPI="4"

inherit git-2 linux-mod autotools-utils

DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zfsonlinux/zfs.git"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug static-libs"

DEPEND=">=sys-kernel/spl-${PV}"
RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse
	sys-apps/util-linux
	test? ( sys-fs/mdadm )"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

pkg_setup() {
	CONFIG_CHECK="!PREEMPT
		!DEBUG_LOCK_ALLOC
		ZLIB_DEFLATE
		ZLIB_INFLATE
		BLK_DEV_LOOP"
	kernel_is ge 2 6 26 || die "Linux 2.6.26 or newer required"
	check_extra_config
}

src_prepare() {
	# Workaround for hard coded path
	sed -i "s|/sbin/lsmod|/bin/lsmod|" scripts/common.sh.in || die
	autotools-utils_src_prepare
}

src_configure() {
	set_arch_to_kernel
	local myeconfargs=(
		--exec-prefix=
		--with-config=all
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		--with-udevdir=/lib/udev
		$(use_enable debug)
	)
	autotools-utils_src_configure
}

src_test() {
	if [[ $UID -ne 0 ]]
	then
		ewarn "Cannot run make check tests with FEATURES=userpriv."
		ewarn "Skipping make check tests."
	else
		autotools-utils_src_test
	fi
}
