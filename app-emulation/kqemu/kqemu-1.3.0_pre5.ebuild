# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/kqemu/kqemu-1.3.0_pre5.ebuild,v 1.5 2012/05/31 22:34:38 zmedico Exp $

inherit eutils flag-o-matic linux-mod toolchain-funcs user

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator kernel fast execution module"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${MY_P}.tar.gz"

LICENSE="KQEMU"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="strip"
IUSE=""

S="${WORKDIR}/$MY_P"

DEPEND=""

pkg_setup() {
	MODULE_NAMES="kqemu(misc:${S})"
	linux-mod_pkg_setup

	einfo "kqemu is binary module with a restricted license."
	einfo "Please read carefully the KQEMU license"
	einfo "and ${HOMEPAGE}qemu-accel.html"
	einfo "if you would like to see it released under the GPL"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-fix_module_parm.patch"
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	./configure --kernel-path="${KV_DIR}" \
		|| die "could not configure"

	make
}

src_install() {
	linux-mod_src_install

	# udev rule
	dodir /etc/udev/rules.d/
	echo 'KERNEL="kqemu*", NAME="%k", GROUP="qemu", MODE="0660"' > ${D}/etc/udev/rules.d/48-qemu.rules

	# Module doc
	dodoc ${S}/README
	dohtml ${S}/kqemu-doc.html

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
