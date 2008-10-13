# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/x48/x48-0.4.3.ebuild,v 1.6 2008/10/13 18:51:39 bangert Exp $

inherit eutils

DESCRIPTION="HP48 Calculator Emulator"
HOMEPAGE="http://x48.berlios.de/"
SRC_URI="mirror://berlios/x48/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-proto/xextproto
	app-text/rman"
DEPEND="${RDEPEND}
	x11-libs/libXext
	x11-libs/libX11
	x11-misc/imake
	app-text/rman
	sys-libs/readline
	sys-libs/ncurses
	sys-libs/gpm"

src_compile() {
	xmkmf || die
	emake CCOPTIONS="${CFLAGS}" LOCAL_LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin src/checkrom src/dump2rom src/mkcard src/x48

	newman src/x48.man x48.1

	dodir /usr/lib/X11/app-defaults
	insinto /usr/lib/X11/app-defaults/
	newins src/X48.ad X48

	dodoc doc/CARDS.doc doc/ROMDump.doc
	dodoc romdump/ROMDump romdump/ROMDump.s
}

pkg_postinst() {
	elog "The X48 emulator requires an HP48 ROM Image to run."
	elog
	elog "You can use the ROMDump utility and documentation included with this"
	elog "package to obtain this from your HP48 calculator."
}
