# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cowloop/cowloop-2.11.ebuild,v 1.1 2005/01/01 15:03:47 dragonheart Exp $

inherit linux-mod

DESCRIPTION="A copy-on-write loop driver (block device) to be used on top of any other block driver"
HOMEPAGE="http://www.atconsultancy.nl/cowloop/"
SRC_URI="http://www.atconsultancy.nl/cowloop/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2.6"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc
	virtual/linux-sources"

MODULE_NAMES="cowloop(misc:${S})"
BUILD_PARAMS="-C ${KERNEL_DIR} SUBDIRS=${S} -I."
BUILD_TARGETS="modules"


pkg_setup() {
	linux-mod_pkg_setup
	einfo "Linux kernel ${KV_FULL}"
	if kernel_is 2 4 || kernel_is 2 5
	then
		eerror "This version only works with 2.6 kernels"
		eerror "For 2.4 kernel support, use version 1.4"
		die "No compatible kernel detected!"
	fi
}

src_compile() {
	linux-mod_src_compile
	emake cowcopy cowrepair cowsync cowlist
}

src_install() {
	linux-mod_src_install
	dosbin cowcopy cowrepair cowsync cowlist
	doman man/*
}
