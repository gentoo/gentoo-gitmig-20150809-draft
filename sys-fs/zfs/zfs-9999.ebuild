# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs/zfs-9999.ebuild,v 1.13 2012/02/27 05:36:38 floppym Exp $

EAPI="4"

inherit flag-o-matic git-2 linux-mod toolchain-funcs autotools-utils

DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zfsonlinux/zfs.git"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="custom-cflags debug static-libs"

DEPEND="
	>=sys-kernel/spl-${PV}
	sys-apps/util-linux[static-libs?]
	sys-libs/zlib[static-libs?]
"
RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse
"
DEPEND+="
	test? ( sys-fs/mdadm )
"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

pkg_setup() {
	CONFIG_CHECK="MODULES
		!PREEMPT
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
	use custom-cflags || strip-flags
	set_arch_to_kernel
	local myeconfargs=(
		--bindir=/bin
		--sbindir=/sbin
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

src_install() {
	autotools-utils_src_install
	gen_usr_ldscript -a uutil nvpair zpool zfs
}
