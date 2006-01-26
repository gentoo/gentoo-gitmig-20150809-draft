# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/x48/x48-0.4.3.ebuild,v 1.1 2006/01/26 20:18:30 taviso Exp $

inherit eutils

DESCRIPTION="HP48 Calculator Emulator"
HOMEPAGE="http://x48.berlios.de/"
SRC_URI="http://download.berlios.de/x48/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="|| ( ( x11-proto/xextproto ) virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libXext x11-libs/libX11 x11-misc/imake ) virtual/x11 )
	sys-libs/readline
	sys-libs/ncurses
	sys-libs/gpm"

src_compile() {
	xmkmf || die
	emake CCOPTIONS="${CFLAGS}" LOCAL_LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin ${S}/src/checkrom ${S}/src/dump2rom ${S}/src/mkcard ${S}/src/x48

	newman ${S}/src/x48.man x48.1

	dodir /usr/lib/X11/app-defaults
	insinto /usr/lib/X11/app-defaults/
	newins ${S}/src/X48.ad X48

	dodoc ${S}/doc/CARDS.doc ${S}/doc/ROMDump.doc
	dodoc ${S}/romdump/ROMDump ${S}/romdump/ROMDump.s
}

pkg_postinst() {
	einfo "The X48 emulator requires an HP48 ROM Image to run."
	einfo
	einfo "You can use the ROMDump utility and documentation included with this"
	einfo "package to obtain this from your HP48 calculator."
}
