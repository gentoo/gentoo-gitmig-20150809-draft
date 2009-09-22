# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/x48/x48-0.6.1.ebuild,v 1.1 2009/09/22 17:56:44 vostorga Exp $

inherit eutils

DESCRIPTION="HP48 Calculator Emulator"
HOMEPAGE="http://x48.berlios.de/"
SRC_URI="mirror://berlios/x48/${P}.tar.gz
	http://www.hpcalc.org/hp48/pc/emulators/sxrom-j.zip
	http://www.hpcalc.org/hp48/pc/emulators/gxrom-r.zip"
LICENSE="|| ( ( GPL-2 free-noncomm ) GPL-2 )"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	app-text/rman
	sys-libs/readline
	sys-libs/ncurses
	app-arch/unzip
	sys-libs/gpm"

src_compile() {
	econf
	emake CCOPTIONS="${CFLAGS}" LOCAL_LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin src/checkrom src/dump2rom src/mkcard src/x48 || die "dobin failed"

	newman src/x48.man x48.1 || die "newman failed"

	dodir /usr/lib/X11/app-defaults || die "dodir failed"
	insinto /usr/lib/X11/app-defaults/

	dodir /usr/share/hp48 || die "dodir failed"
	insinto /usr/share/hp48
	doins "${WORKDIR}"/gxrom-r "${WORKDIR}"/sxrom-j || die "doins failed"

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
