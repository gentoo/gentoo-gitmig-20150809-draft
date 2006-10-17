# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/boot0/boot0-6.2_beta2.ebuild,v 1.2 2006/10/17 10:00:30 uberlord Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's bootloader"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${SYS}.tar.bz2"

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-lib-${RV}*"

S="${WORKDIR}/sys/boot"

PATCHES="${FILESDIR}/boot0-6.0-gentoo.patch
	${FILESDIR}/freebsd-sources-6.2-sparc64.patch"

src_unpack() {
	freebsd_src_unpack

	grep -Zlr -- -ffreestanding "${S}" | xargs -0 sed -i -e \
		"s:-ffreestanding:-ffreestanding $(test-flags -fno-stack-protector -fno-stack-protector-all):g"
}

src_install() {
	dodir /boot/defaults

	mkinstall FILESDIR=/boot || die "mkinstall failed"
}
