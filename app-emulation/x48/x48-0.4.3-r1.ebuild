# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/x48/x48-0.4.3-r1.ebuild,v 1.17 2008/10/13 18:51:39 bangert Exp $

inherit eutils

DESCRIPTION="HP48 Calculator Emulator"
HOMEPAGE="http://x48.berlios.de/"
SRC_URI="mirror://berlios/x48/${P}.tar.gz
	http://www.hpcalc.org/hp48/pc/emulators/sxrom-j.zip
	http://www.hpcalc.org/hp48/pc/emulators/gxrom-r.zip"
LICENSE="|| ( ( GPL-2 free-noncomm ) GPL-2 )"

SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~ia64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-misc/imake
	app-text/rman
	sys-libs/readline
	sys-libs/ncurses
	app-arch/unzip
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

	dodir /usr/share/hp48
	insinto /usr/share/hp48
	doins "${WORKDIR}"/gxrom-r "${WORKDIR}"/sxrom-j

	dodoc doc/CARDS.doc doc/ROMDump.doc
	dodoc romdump/ROMDump romdump/ROMDump.s
}

pkg_postinst() {
	elog "The X48 emulator requires an HP48 ROM Image to run."
	elog
	elog "If you own an HP-48 calculator, you can use the ROMDump utility"
	elog "included with this package to obtain this from your calculator."
	elog
	elog "Alternatively, HP has provided two ROM images for non-commercial"
	elog "use only."
	elog
	elog "For an HP-48SX type: x48 -rom /usr/share/hp48/sxrom-j"
	elog "For an HP-48GX type: x48 -rom /usr/share/hp48/gxrom-r"
	elog
	elog "(If you're not sure which one you want, go with HP-48GX)"
	elog
	elog "Note: you only need to use the '-rom' argument once"
}
