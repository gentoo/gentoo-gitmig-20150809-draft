# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tuxonice-userui/tuxonice-userui-1.0.ebuild,v 1.5 2010/12/12 14:57:04 nelchael Exp $

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="User Interface for TuxOnIce"
HOMEPAGE="http://www.tuxonice.net"
SRC_URI="http://www.tuxonice.net/downloads/all/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="fbsplash"
DEPEND="fbsplash? ( >=media-gfx/splashutils-1.5.2.1
	media-libs/libmng[lcms]
	media-libs/lcms:0[static-libs] )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-Makefiles.patch"
}

src_compile() {
	# Package contain binaries
	emake clean

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		tuxoniceui_text || die "emake tuxoniceui_text failed"

	if use fbsplash; then
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
			tuxoniceui_fbsplash || die "emake tuxoniceui_fbsplash failed"
	fi
}

src_install() {
	into /
	dosbin tuxoniceui_text
	use fbsplash && dosbin tuxoniceui_fbsplash
	dodoc AUTHORS ChangeLog KERNEL_API README TODO USERUI_API
}

pkg_postinst() {
	if use fbsplash; then
		einfo
		einfo "You must create a symlink from /etc/splash/tuxonice"
		einfo "to the theme you want tuxonice to use, e.g.:"
		einfo
		einfo "  # ln -sfn /etc/splash/emergence /etc/splash/tuxonice"
	fi
	einfo
	einfo "Please see /usr/share/doc/${PF}/README.* for further"
	einfo "instructions."
	einfo
}
