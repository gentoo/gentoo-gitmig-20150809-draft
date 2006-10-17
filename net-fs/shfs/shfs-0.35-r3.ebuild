# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/shfs/shfs-0.35-r3.ebuild,v 1.6 2006/10/17 20:56:07 gustavoz Exp $

inherit linux-mod eutils

DESCRIPTION="Secure Shell File System"
HOMEPAGE="http://shfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="X amd doc"

RDEPEND="virtual/modutils
		net-misc/openssh
		amd? ( net-fs/am-utils )"
DEPEND="virtual/linux-sources
		sys-apps/sed
		${RDEPEND}"
PDEPEND="X? ( net-misc/x11-ssh-askpass )"

CONFIG_CHECK="@SH_FS:shfs"
SH_FS_ERROR="SHFS is built into the kernel.  Only userland utilities will be provided."

pkg_setup() {
	linux-mod_pkg_setup

	# Setup the Kernel module build
	BUILD_PARAMS="-j1 KERNEL_SOURCES=${KV_DIR}"

	# List the kernel modules that will be built
	MODULE_NAMES="shfs(misc/fs:${S}/shfs/Linux-${KV_MAJOR}.${KV_MINOR})"

	case "${KV_MAJOR}.${KV_MINOR}" in
		"2.4") BUILD_TARGETS="all" ;;
		"2.6") BUILD_TARGETS="default" ;;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/0.35/*.patch

	# Take care of 2.6 Kernels <= 2.6.6
	if [[ "${KV_MAJOR}.${KV_MINOR}" == "2.6" ]]  ; then
		convert_to_m ${S}/shfs/Linux-2.6/Makefile
	fi

	# 2.6.16 has a modified dentry struct.  Patch by Miroslav Spousta
	# <qiq@ucw.cz>.  Submitted by Torsten Krah (bug #127092).
	if kernel_is ge 2 6 16 ; then
		epatch ${FILESDIR}/${PN}-0.35-2.6.16-dentry.patch
	fi
}

src_compile() {
	linux-mod_src_compile

	cd ${S}/shfsmount
	emake || die "failed to build userland utilities"
}

src_install() {
	# Install kernel module
	linux-mod_src_install

	# Install userland utilities
	cd ${S}/shfsmount
	dobin shfsmount
	dobin shfsumount

	if use amd ; then
		insinto /etc/amd
		doins ${FILESDIR}/amd.conf
		doins ${FILESDIR}/amd.shfs

		exeinto /etc/amd
		doexe ${FILESDIR}/shfs.mount
		dosym /etc/amd/shfs.mount /etc/amd/shfs.unmount
	fi

	# Setup permissions
	einfo "Setting SUID bit on /usr/bin executables..."
	fperms 4511 /usr/bin/shfsmount
	fperms 4511 /usr/bin/shfsumount

	# Create symlinks to support mount(8)
	einfo "Adding /sbin/mount.shfs symlink..."
	dodir /sbin
	dosym /usr/bin/shfsmount /sbin/mount.shfs

	# Install docs
	doman ${S}/docs/manpages/shfsmount.8 ${S}/docs/manpages/shfsumount.8
	use doc && dohtml -r ${S}/docs/html
}

pkg_postinst() {
	linux-mod_pkg_postinst

	echo
	einfo "Use either 'shfsmount' or 'mount -t shfs' to mount remote"
	einfo "filesystems into your local filesystem."
	echo
	einfo "Note the following:"
	einfo
	einfo " 1. The shfs kernel module has to be loaded first before you can"
	einfo "    start mounting filesystems."
	einfo "    Try: 'modprobe shfs' as root."
	einfo
	einfo " 2. When mouting, you must enter the absolute path of the remote"
	einfo "    filesystem without any special characters such as tilde (~),"
	einfo "    for example as they will not be evaluated."
	echo
}
