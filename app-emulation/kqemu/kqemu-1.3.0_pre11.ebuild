# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/kqemu/kqemu-1.3.0_pre11.ebuild,v 1.8 2012/05/31 22:34:38 zmedico Exp $

inherit eutils flag-o-matic linux-mod toolchain-funcs user

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator kernel fast execution module"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE=""

S="${WORKDIR}/$MY_P"

DEPEND=""

pkg_setup() {
	MODULE_NAMES="kqemu(misc:${S})"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sched_h.patch
	sed -i 's:MODULE_PARM(\([^,]*\),"i");:module_param(\1, int, 0);:' kqemu-linux.c
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	./configure --kernel-path="${KV_DIR}" \
		|| die "could not configure"

	make || die "make failed"
}

src_install() {
	linux-mod_src_install

	# udev rule
	dodir /etc/udev/rules.d/
	echo 'KERNEL=="kqemu*", NAME="%k", GROUP="qemu", MODE="0660"' > ${D}/etc/udev/rules.d/48-qemu.rules

	# Module doc
	dodoc ${S}/README
	dohtml ${S}/kqemu-doc.html

}

pkg_postinst() {
	linux-mod_pkg_postinst
	enewgroup qemu
	elog "Make sure you have the kernel module loaded before running qemu"
	elog "and your user is in the 'qemu' group"
	case ${CHOST} in
		*-darwin*) elog "Just run 'niutil -appendprop / /groups/qemu users <USER>'";;
		*-freebsd*|*-dragonfly*) elog "Just run 'pw groupmod qemu -m <USER>'";;
		*) elog "Just run 'gpasswd -a <USER> qemu', then have <USER> re-login.";;
	esac
}
