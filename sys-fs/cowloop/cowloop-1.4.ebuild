# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cowloop/cowloop-1.4.ebuild,v 1.1 2005/01/01 21:30:42 dragonheart Exp $

inherit linux-mod toolchain-funcs

DESCRIPTION="A copy-on-write loop driver (block device) to be used on top of any other block driver"
HOMEPAGE="http://www.atconsultancy.nl/cowloop/"
SRC_URI="http://www.atconsultancy.nl/cowloop/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2.4"
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
	if ! kernel_is 2 4
	then
		eerror "This version only works with 2.4 kernels"
		eerror "For 2.6 kernel support, use version 2.11 or later"
		die "No compatible kernel detected!"
	fi
}

src_compile() {
	$(tc-getCC) -O2 -s -I. -D__KERNEL__ -DLINUX -DMODULE -DCOWMAJOR=241 \
		-I${KERNEL_DIR}/include ${CFLAGS} -c cowloop.c \
		|| die "module compile failure"
}

src_install() {
	linux-mod_src_install
	doman man/*
}
