# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmciautils/pcmciautils-004.ebuild,v 1.1 2005/06/30 09:21:50 brix Exp $

inherit eutils toolchain-funcs linux-info

DESCRIPTION="PCMCIA userspace utilities for Linux kernel 2.6.13 and beyond"

HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/pcmcia/"
SRC_URI="mirror://kernel/linux/utils/kernel/pcmcia/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="cis debug staticsocket"
DEPEND="dev-util/yacc
		sys-devel/flex
		sys-apps/sed"
RDEPEND=">=sys-fs/sysfsutils-1.2.0-r1
		>=sys-apps/module-init-tools-3.2_pre4
		>=sys-apps/hotplug-20040920
		>=sys-apps/coldplug-20040920
		cis? ( sys-apps/pcmcia-cs-cis )"
PROVIDE="virtual/pcmcia"

CONFIG_CHECK="PCMCIA"
ERROR_PCMCIA="${P} requires 16-bit PCMCIA support (CONFIG_PCMCIA)"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 13; then
		eerror
		eerror "${P} requires at least kernel 2.6.13."
		eerror
		die "${P} requires at least kernel 2.6.13."
	fi
}

src_unpack() {
	unpack ${A}

	sed -i -e "s:^\(KERNEL_DIR\) = .*:\1 = ${KV_DIR}:" ${S}/Makefile

	if use debug; then
		sed -i \
			-e "s:^\(DEBUG\) = .*:\1 = true:" \
			-e "s:^\(V\)=false:\1=true:" \
			${S}/Makefile
	fi

	if use staticsocket; then
		sed -i -e "s:^\(STARTUP\) = .*:\1 = false:" ${S}/Makefile
	fi
}

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1" \
		emake CC="$(tc-getCC)" LD="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	einfo
	einfo "A mini-HOWTO for using pcmciautils can be found at:"
	einfo "http://www.kernel.org/pub/linux/utils/kernel/pcmcia/howto.html"
	ewarn
	ewarn "If you relied on pcmcia-cs to automatically load the"
	ewarn "appropriate PCMCIA-related modules upon boot, you need"
	ewarn "to add "
	ewarn "		pcmcia"
	ewarn "and the PCMCIA socket driver you need for this system"
	ewarn "(yenta-socket, i82092, i82365, ...) to"
	ewarn "/etc/modules.autoload.d/kernel-2.6"
	ewarn
}
