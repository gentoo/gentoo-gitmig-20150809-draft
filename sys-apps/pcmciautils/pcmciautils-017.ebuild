# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmciautils/pcmciautils-017.ebuild,v 1.4 2012/10/31 19:24:28 ssuominen Exp $

EAPI=4
inherit flag-o-matic linux-info toolchain-funcs udev

DESCRIPTION="PCMCIA userspace utilities for Linux kernel 2.6.13 and beyond"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/pcmcia/"
SRC_URI="mirror://kernel/linux/utils/kernel/pcmcia/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE="debug static staticsocket"

RDEPEND=">=sys-fs/sysfsutils-1.3.0
	virtual/modutils"
DEPEND="${RDEPEND}
	virtual/yacc
	sys-devel/flex"

CONFIG_CHECK="~PCMCIA"
ERROR_PCMCIA="${P} requires 16-bit PCMCIA support (CONFIG_PCMCIA)"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 13 && ewarn "${P} requires at least kernel 2.6.13."
}

use_tf() { use $1 && echo true || echo false ; }
src_prepare() {
	sed -i \
		-e '/^DEBUG\>/s:=.*:= false:' \
		-e '/^UDEV\>/s:=.*:= true:' \
		-e '/CFLAGS/s:-fomit-frame-pointer::' \
		-e '/^STATIC\>/s:=.*:= '$(use_tf static)':' \
		-e '/^STARTUP\>/s:=.*:= '$(use_tf staticsocket)':' \
		Makefile || die
	use debug && append-flags -DDEBUG
}

src_compile() {
	emake \
		OPTIMIZATION="${CFLAGS} ${CPPFLAGS}" \
		V=true \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		STRIP=true
}

src_install() {
	emake \
		DESTDIR="${D}" \
		udevdir="$(udev_get_udevdir)" \
		install

	dodoc doc/*.txt
}

pkg_postinst() {
	ewarn "If you relied on pcmcia-cs to automatically load the appropriate"
	ewarn "PCMCIA-related modules upon boot, you need to add 'pcmcia' and the"
	ewarn "PCMCIA socket driver you need for this system (yenta-socket,"
	ewarn "i82092, i82365, ...) to /etc/modules.autoload.d/kernel-2.6"
}
