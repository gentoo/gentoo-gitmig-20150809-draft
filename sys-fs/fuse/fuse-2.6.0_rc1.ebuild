# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse/fuse-2.6.0_rc1.ebuild,v 1.6 2006/10/20 03:40:33 josejx Exp $

inherit linux-mod eutils libtool

MY_P=${P/_/-}
DESCRIPTION="An interface for filesystems implemented in userspace."
HOMEPAGE="http://fuse.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kernel_linux kernel_FreeBSD"
S=${WORKDIR}/${MY_P}
PDEPEND="kernel_FreeBSD? ( sys-fs/fuse4bsd )"

MODULE_NAMES="fuse(fs:${S}/kernel)"
CONFIG_CHECK="@FUSE_FS:fuse"
BUILD_PARAMS="majver=${KV_MAJOR}.${KV_MINOR}
			  fusemoduledir=${ROOT}/lib/modules/${KV_FULL}/fs"
BUILD_TARGETS="all"
ECONF_PARAMS="--with-kernel=${KV_OUT_DIR}"
FUSE_FS_ERROR="We have detected FUSE already built into the kernel.
We will continue, but we wont build the module this time."

pkg_setup() {
	use kernel_linux && linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fuse-fix-lazy-binding.patch
	elibtoolize
}

src_compile() {
	einfo "Preparing fuse userland"
	econf --disable-kernel-module --disable-example || \
		die "econf failed for fuse userland"
	emake || die "emake failed"

	if use kernel_linux; then
		sed -i -e 's/.*depmod.*//g' ${S}/kernel/Makefile.in
		convert_to_m ${S}/kernel/Makefile.in
		linux-mod_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog Filesystems README README-2.4 \
		README.NFS NEWS doc/how-fuse-works
	docinto example
	dodoc example/*

	if use kernel_linux; then
		linux-mod_src_install
	else
		insinto /usr/include/fuse
		doins include/fuse_kernel.h
	fi
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst
}
