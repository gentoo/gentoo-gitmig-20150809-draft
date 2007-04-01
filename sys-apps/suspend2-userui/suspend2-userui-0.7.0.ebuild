# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/suspend2-userui/suspend2-userui-0.7.0.ebuild,v 1.3 2007/04/01 07:59:57 alonbl Exp $

inherit toolchain-funcs eutils

DESCRIPTION="User Interface for Software Suspend 2"
HOMEPAGE="http://www.suspend2.net"
SRC_URI="http://www.suspend2.net/downloads/all/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="fbsplash"
DEPEND="virtual/libc
		fbsplash? (	sys-libs/zlib
					media-libs/freetype
					media-libs/jpeg
					media-libs/lcms
					>=media-libs/libmng-1.0.5
					media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-syscall.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		suspend2ui_text || die "emake suspend2ui_text failed"

	if use fbsplash; then
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
			fbsplash || die "emake fbsplash failed"
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
			suspend2ui_fbsplash || die "emake suspend2ui_fbsplash failed"
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
		einfo "to the theme you want suspend2ui_fbsplash to use, e.g.:"
		einfo
		einfo "  # ln -sfn /etc/splash/emergence /etc/splash/suspend2"
	fi

	einfo
	einfo "Please see /usr/share/doc/${PF}/README.gz for further"
	einfo "instructions."
	einfo
}
