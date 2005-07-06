# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/suspend2-userui/suspend2-userui-0.5.1.ebuild,v 1.1 2005/07/06 10:54:58 brix Exp $

inherit toolchain-funcs eutils

DESCRIPTION="User Interface for Software Suspend 2"
HOMEPAGE="http://www.suspend2.net"
SRC_URI="http://www.suspend2.net/downloads/all/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="fbsplash"
DEPEND="virtual/libc
		fbsplash? (	sys-libs/zlib
					media-libs/freetype
					media-libs/jpeg
					media-libs/lcms
					>=media-libs/libmng-1.0.5
					media-libs/libpng )"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" suspend2ui_text \
		|| die "emake userui_text failed"

	if use fbsplash; then
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" fbsplash \
			|| die "emake fbsplash failed"
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" suspend2ui_fbsplash \
			|| die "emake userui_fbsplash failed"
	fi
}

src_install() {
	into /
	dosbin suspend2ui_text
	use fbsplash && dosbin suspend2ui_fbsplash

	dodoc AUTHORS ChangeLog KERNEL_API README TODO USERUI_API
}

pkg_postinst() {
	if use fbsplash; then
		einfo
		einfo "You must create a symlink from /etc/splash/suspend2"
		einfo "to the theme you want userui_fbsplash to use, e.g.:"
		einfo
		einfo "  # ln -sfn /etc/splash/emergence /etc/splash/suspend2"
	fi

	einfo
	einfo "Please see /usr/share/doc/${PF}/README.gz for further"
	einfo "instructions."
	einfo
}
