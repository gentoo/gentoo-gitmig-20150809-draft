# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/kqemu/kqemu-0.7.2.ebuild,v 1.5 2006/04/19 21:54:59 lu_zero Exp $

inherit eutils flag-o-matic linux-mod toolchain-funcs

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator kernel fast execution module"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/qemu-${PV}.tar.gz
		 http://fabrice.bellard.free.fr/qemu/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 KQEMU"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="nostrip"
IUSE="sdl"

S="${WORKDIR}/qemu-${PV}"

DEPEND="virtual/libc
		>=app-emulation/qemu-softmmu-0.8.0"

pkg_setup() {
	MODULE_NAMES="kqemu(misc:${S}/kqemu)"
	linux-mod_pkg_setup

	einfo "kqemu is binary module with a restricted license."
	einfo "Please read carefully the KQEMU license"
	einfo "and ${HOMEPAGE}qemu-accel.html"
	einfo "if you would like to see it released under the GPL"
}

src_unpack() {
	unpack ${A}

	mv ${WORKDIR}/kqemu ${S}
	cd ${S}/kqemu
	sed -i -e 's:#ifndef PAGE_KERNEL_EXEC:#if 1:' ${S}/kqemu/kqemu-linux.c
	# The class_simple interfaces were removed in 2.6.13-rc1, leaving only
	# GPL symbols behind, which this module can't use.  Until there's a fix
	# from Fabrice, kqemu+udev no worky.
	cd ${S}

	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	myconf=""
	if ! use sdl ; then
		myconf="$myconf --disable-gfx-check"
	fi
	./configure \
		--prefix=/usr \
		--target-list="${TARGET_LIST}" \
		--enable-slirp \
		--kernel-path=${KV_DIR} \
		--enable-kqemu \
		${myconf} \
		|| die "could not configure"

	emake -C kqemu || die "make failed"
}

src_install() {
	linux-mod_src_install

	# udev rule
	dodir /etc/udev/rules.d/
	echo 'KERNEL="kqemu*", NAME="%k", GROUP="qemu", MODE="0660"' > ${D}/etc/udev/rules.d/48-qemu.rules

	# Module doc
	dodoc ${S}/kqemu/README

	# module params
	dodir /etc/modules.d
	echo "options kqemu major=0" > ${D}/etc/modules.d/kqemu
}

pkg_postinst() {
	linux-mod_pkg_postinst
	enewgroup qemu
	einfo "Make sure you have the kernel module loaded before running qemu"
	einfo "and your user is in the qemu group"
}
