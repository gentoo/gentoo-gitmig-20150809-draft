# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse/fuse-1.4.ebuild,v 1.1 2004/11/16 17:21:49 genstef Exp $

inherit kernel-mod

MY_P=${P/_/-}
DESCRIPTION="An interface for filesystems implemented in userspace."
HOMEPAGE="http://sourceforge.net/projects/fuse"
SRC_URI="mirror://sourceforge/fuse/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND="virtual/linux-sources"

pkg_setup() {
	kernel-mod_check_modules_supported
}

src_compile() {
	econf --disable-example --with-kernel="${ROOT}/usr/src/linux" || die "econf failed"

	sed -i 's/.*depmod.*//' kernel/Makefile

	# http://marc.theaimsgroup.com/?l=gentoo-dev&m=109672618708314&w=2
	kernel-mod_getversion
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' kernel/Makefile
	fi

	unset ARCH
	emake || die "emake failed"
}

src_install() {
	unset ARCH
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog Filesystems README README-2.4 \
		README-2.6 README.NFS NEWS doc/how-fuse-works
	docinto example
	dodoc example/*
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
