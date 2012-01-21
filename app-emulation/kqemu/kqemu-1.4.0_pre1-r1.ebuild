# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/kqemu/kqemu-1.4.0_pre1-r1.ebuild,v 1.6 2012/01/21 20:49:13 slyfox Exp $

inherit eutils flag-o-matic linux-mod toolchain-funcs

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator kernel fast execution module"
HOMEPAGE="http://bellard.org/qemu/"
SRC_URI="http://bellard.org/qemu/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND=""

pkg_setup() {
	MODULE_NAMES="kqemu(misc:${S})"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:MODULE_PARM(\([^,]*\),"i");:module_param(\1, int, 0);:' kqemu-linux.c
	sed -e 's:-Werror::' -i common/Makefile #260876
	sed -e '/^CC/d;/^HOST_CC/d;' \
		-e 's/\(^MON_CC=\).*/\1$(CC)/' \
		-e "s/\(^MON_LD=\).*/\1$(tc-getLD)/" \
		-e 's/^\(TOOLS_CFLAGS.*\)/\1 $(CFLAGS)/' \
		-e 's/^\(MON_CFLAGS.*\)/\1 $(CFLAGS)/' \
		-e 's/^\(KERNEL_CFLAGS.*\)/\1 $(CFLAGS)/' \
		-e 's/^CFLAGS=\(.*\)/CFLAGS+=\1/' \
		-i common/Makefile
	epatch "${FILESDIR}/${P}-missing-sched-header.patch"
	epatch "${FILESDIR}"/${P}-init_MUTEX.patch
	epatch "${FILESDIR}"/${P}-remove-smp_lock.patch #368439
}

src_compile() {
	filter-flags -fpie -fstack-protector -ftracer #263837

	./configure --kernel-path="${KV_DIR}" \
				--cc="$(tc-getCC)" \
				--host-cc="$(tc-getBUILD_CC)" \
				--extra-cflags="${CFLAGS}" \
				--extra-ldflags="${LDFLAGS}" \
		|| die "could not configure"

	make || die "Make failed"
}

src_install() {
	linux-mod_src_install

	# udev rule
	dodir /etc/udev/rules.d/
	echo 'KERNEL=="kqemu*", GROUP="qemu", MODE="0660"' > ${D}/etc/udev/rules.d/48-qemu.rules

	# Module doc
	dodoc "${S}/README"
	dohtml "${S}/kqemu-doc.html"

	# module params
	dodir /etc/modprobe.d
	echo "options kqemu major=0" > ${D}/etc/modprobe.d/kqemu.conf
}

pkg_preinst() {
	linux-mod_pkg_preinst
	local old1="${ROOT}/etc/modprobe.d/kqemu"
	local old2="${ROOT}/etc/modules.d/kqemu"
	local new="${ROOT}/etc/modprobe.d/kqemu.conf"
	if [[ ! -a "${new}" ]]; then
		if [[ -a "${old1}" ]]; then
			elog "Renaming /etc/modprobe.d/kqemu to /etc/modprobe.d/kqemu.conf"
			mv "${old1}" "${new}"
		elif [[ -a "${old2}" ]]; then
			elog "Moving old kqemu configuration in /etc/modules.d to new"
			elog "location in /etc/modprobe.d"
			mv "${old2}" "${new}"
		fi
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst
	enewgroup qemu
	elog "Make sure you have the kernel module loaded before running qemu"
	elog "and your user is in the 'qemu' group"
}
