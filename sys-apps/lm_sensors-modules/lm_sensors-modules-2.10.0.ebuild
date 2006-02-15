# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors-modules/lm_sensors-modules-2.10.0.ebuild,v 1.1 2006/02/15 18:35:54 brix Exp $

inherit eutils toolchain-funcs linux-info

MY_P=${P/-modules/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Hardware Monitoring kernel modules for linux-2.4.x"
HOMEPAGE="http://secure.netroedge.com/~lm78/"
SRC_URI="http://secure.netroedge.com/~lm78/archive/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 -ppc ~x86"

IUSE=""
DEPEND="sys-apps/i2c"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 4 10; then
		eerror "${P} requires kernel 2.4.10 or later"
		die "${P} requires kernel 2.4.10 or later"
	fi

	if kernel_is gt 2 4; then
		eerror "${P} is only needed for kernel 2.4.x"
		eerror "You need to use the in-kernel I2C drivers for later kernels."
		die "Non 2.4.x kernel detected"
	fi

	if linux_chkconfig_present I2C; then
		eerror "${P} requires kernel CONFIG_I2C to be disabled."
		die "Kernel with CONFIG_I2C detected"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${MY_P}-module-path.patch
	epatch ${FILESDIR}/${MY_P}-modules-only.patch
}

src_compile()  {
	einfo
	einfo "You may safely ignore any errors from compilation"
	einfo "that contain \"No such file or directory\" references."
	einfo

	emake CC=$(tc-getCC) LINUX=${KV_DIR} I2C_HEADERS=${KV_DIR}/include \
		|| die "emake failed"
}

src_install() {
	emake CC=$(tc-getCC) \
		LINUX=${KV_DIR} MODPREF=/lib/modules/${KV_FULL} DESTDIR=${D} install \
		|| die "emake install failed"
}
