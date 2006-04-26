# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmciautils/pcmciautils-013.ebuild,v 1.2 2006/04/26 15:06:57 brix Exp $

inherit toolchain-funcs linux-info

DESCRIPTION="PCMCIA userspace utilities for Linux kernel 2.6.13 and beyond"

HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html"
SRC_URI="mirror://kernel/linux/utils/kernel/pcmcia/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh x86"

IUSE="debug static staticsocket udev"
RDEPEND=">=sys-fs/sysfsutils-1.2.0-r1
		>=sys-apps/module-init-tools-3.2_pre4
		udev? ( >=sys-fs/udev-068 )
		!udev? ( >=sys-apps/hotplug-20040920 )"
DEPEND="${RDEPEND}
		dev-util/yacc
		sys-devel/flex
		sys-apps/sed"

CONFIG_CHECK="~PCMCIA"
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

	sed -i \
		-e "s:^\(KERNEL_DIR\) = .*:\1 = ${KV_DIR}:" \
		-e "s:^\(V\) = false:\1 = true:" \
		-e "s:^\(CFLAGS \:=.*\):\1 ${CFLAGS}:" \
		${S}/Makefile || die

	if use debug; then
		sed -i -e "s:^\(DEBUG\) = .*:\1 = true:" ${S}/Makefile || die
	fi

	if use static; then
		sed -i -e "s:^\(STATIC\) = .*:\1 = true:" ${S}/Makefile || die
	fi

	if use staticsocket; then
		sed -i -e "s:^\(STARTUP\) = .*:\1 = false:" ${S}/Makefile || die
	fi

	if use udev; then
		sed -i -e "s:^\(UDEV\) = .*:\1 = true:" ${S}/Makefile || die
	else
		sed -i -e "s:^\(UDEV\) = .*:\1 = false:" ${S}/Makefile || die
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/*.txt
}

pkg_postinst() {
	ewarn
	ewarn "If you relied on pcmcia-cs to automatically load the appropriate"
	ewarn "PCMCIA-related modules upon boot, you need to add 'pcmcia' and the"
	ewarn "PCMCIA socket driver you need for this system (yenta-socket,"
	ewarn "i82092, i82365, ...) to /etc/modules.autoload.d/kernel-2.6"
	ewarn
}
