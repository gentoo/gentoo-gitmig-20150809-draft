# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/x48/x48-0.4.3-r1.ebuild,v 1.11 2006/07/08 08:04:29 corsair Exp $

inherit eutils

DESCRIPTION="HP48 Calculator Emulator"
HOMEPAGE="http://x48.berlios.de/"
SRC_URI="http://download.berlios.de/x48/${P}.tar.gz
	http://www.hpcalc.org/hp48/pc/emulators/sxrom-j.zip
	http://www.hpcalc.org/hp48/pc/emulators/gxrom-r.zip"
LICENSE="|| ( ( GPL-2 free-noncomm ) GPL-2 )"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libXext x11-libs/libX11 ) virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( 	x11-proto/xextproto
			x11-misc/imake
			app-text/rman )
	     virtual/x11 )
	sys-libs/readline
	sys-libs/ncurses
	app-arch/unzip
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

	dodir /usr/share/hp48
	insinto /usr/share/hp48
	doins ${WORKDIR}/gxrom-r ${WORKDIR}/sxrom-j

	dodoc ${S}/doc/CARDS.doc ${S}/doc/ROMDump.doc
	dodoc ${S}/romdump/ROMDump ${S}/romdump/ROMDump.s
}

pkg_postinst() {
	einfo "The X48 emulator requires an HP48 ROM Image to run."
	einfo
	einfo "If you own an HP-48 calculator, you can use the ROMDump utility"
	einfo "included with this package to obtain this from your calculator."
	einfo
	einfo "Alternatively, HP has provided two ROM images for non-commercial"
	einfo "use only."
	einfo
	einfo "For an HP-48SX type: x48 -rom /usr/share/hp48/sxrom-j"
	einfo "For an HP-48GX type: x48 -rom /usr/share/hp48/gxrom-r"
	einfo
	einfo "(If you're not sure which one you want, go with HP-48GX)"
	einfo
	einfo "Note: you only need to use the '-rom' argument once"
}
