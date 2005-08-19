# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c/i2c-2.9.1.ebuild,v 1.5 2005/08/19 15:35:45 brix Exp $

inherit eutils toolchain-funcs linux-info

DESCRIPTION="I2C Bus support for 2.4.x kernels"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78/"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -ppc x86"

IUSE=""

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 4 10; then
		eerror "${PV} requires kernel 2.4.10 or later"
		die "${PV} requires kernel 2.4.10 or later"
	fi

	if kernel_is gt 2 4; then
		eerror "${PV} is only needed for kernel 2.4.x"
		eerror "You need to use the in-kernel I2C drivers for later kernels."
		die "Non 2.4.x kernel detected"
	fi

	if linux_chkconfig_present I2C; then
		eerror "${PV} requires kernel CONFIG_I2C to be disabled."
		die "Kernel with CONFIG_I2C detected"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-module-path.patch
}

src_compile ()  {
	einfo
	einfo "You may safely ignore any errors from compilation"
	einfo "that contain \"No such file or directory\" references."
	einfo

	emake CC=$(tc-getCC) LINUX=${KV_DIR} || die "emake failed"
}

src_install() {
	einfo
	einfo "This package will need to overwrite your kernel I2C headers."
	einfo "If this fails, please emerge with FEATURES=\"-collision-protect\""
	einfo
	ebeep 5

	emake CC=$(tc-getCC) \
		LINUX=${KV_DIR} LINUX_INCLUDE_DIR=${KV_DIR}/include/linux MODPREF=/lib/modules/${KV_FULL} \
		DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man install \
		|| die "emake install failed"

	dodoc CHANGES README TODO

	dodoc doc/*
}
