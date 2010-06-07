# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/echinus/echinus-0.4.3.2.ebuild,v 1.1 2010/06/07 12:24:52 xarthisius Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A window manager for X in the spirit of dwm"
HOMEPAGE="http://plhk.ru/echinus"
SRC_URI="http://plhk.ru/static/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README || die

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	if ! has_version x11-misc/dmenu; then
		elog "Installing ${PN} without x11-misc/dmenu"
		elog "To have a menu you can install x11-misc/dmenu"
		elog "and use \"Echinus*spawn\" in echinusrc"
		elog "to launch dmenu_run. Check echinus documentation for details."
		elog ""
	fi
	# x11-misc/ourico is not in portage atm, this will change soon.
	#if ! has_version x11-misc/ourico; then
	#	elog "Installing ${PN} without x11-misc/ourico"
	#	elog "To have a taskbar you can install x11-misc/ourico"
	#	elog ""
	#fi
	elog "A standard config file with its pixmaps has been installed to:"
	elog "${PREFIX}/usr/share/${PN}/examples"
	elog "Copy this folder to ~/.${PN}/ and modify the echinusrc as you wish."
	elog ""
	elog "For changing the modkey you can use \"Echinus*modkey: X\""
	elog "in echinusrc. Replace the X with A for ALT, W for Winkey (Super),"
	elog "S for Shift or C for the Control key."
}
