# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse/fuse-2.2_pre3.ebuild,v 1.1 2005/01/15 19:32:24 genstef Exp $

inherit linux-mod eutils

MY_P=${P/_/-}
DESCRIPTION="An interface for filesystems implemented in userspace."
HOMEPAGE="http://sourceforge.net/projects/fuse"
SRC_URI="mirror://sourceforge/fuse/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
S=${WORKDIR}/${MY_P}
MODULE_NAMES="fuse(fs:${S}/kernel)"
BUILD_PARAMS="majver=${KV_MAJOR}.${KV_MINOR}
	fusemoduledir=${ROOT}/lib/modules/${KV_FULL}/fs"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup

	if linux_chkconfig_present FUSE_FS
	then
		einfo "Not compiling the kernel module as it is already in the kernel"
		FUSEMOD=""
	else
		einfo "Compiling the kernel module as it is not yet in the kernel"
		FUSEMOD="true"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fuse-fix-lazy-binding.patch
}

src_compile() {
	econf --disable-kernel-module --disable-example || die "econf failed"
	emake || die "emake failed"

	if [ -n "${FUSEMOD}" ]
	then
		cd kernel
		econf --with-kernel="${ROOT}${KV_DIR}" || die "econf kernel failed"
		sed -i 's/.*depmod.*//' Makefile
		convert_to_m Makefile
		linux-mod_src_compile
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog Filesystems README README-2.4 \
		README-2.6 README.NFS NEWS doc/how-fuse-works
	docinto example
	dodoc example/*

	if [ -n "${FUSEMOD}" ]
	then
		linux-mod_src_install
	fi
}

pkg_postinst() {
	if [ -n "${FUSEMOD}" ]
	then
		linux-mod_pkg_postinst
	fi
}
