# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse/fuse-1.4.ebuild,v 1.3 2005/01/01 23:01:06 genstef Exp $

inherit linux-mod

MY_P=${P/_/-}
DESCRIPTION="An interface for filesystems implemented in userspace."
HOMEPAGE="http://sourceforge.net/projects/fuse"
SRC_URI="mirror://sourceforge/fuse/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
S=${WORKDIR}/${MY_P}
MODULE_NAMES="fuse(fs:${S}/kernel)"
BUILD_PARAMS="majver=${KV_MAJOR}.${KV_MINOR}
	fusemoduledir=${ROOT}/lib/modules/${KV_FULL}/fs"
BUILD_TARGETS="all"


src_compile() {
	econf --disable-kernel-module --disable-example || die "econf failed"
	emake || die "emake failed"

	cd kernel
	econf --with-kernel="${ROOT}${KV_DIR}" || die "econf kernel failed"
	sed -i 's/.*depmod.*//' Makefile
	convert_to_m Makefile
	linux-mod_src_compile
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog Filesystems README README-2.4 \
		README-2.6 README.NFS NEWS doc/how-fuse-works
	docinto example
	dodoc example/*

	linux-mod_src_install
}
