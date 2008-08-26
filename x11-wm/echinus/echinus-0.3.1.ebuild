# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/echinus/echinus-0.3.1.ebuild,v 1.2 2008/08/26 11:43:57 yngwin Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A window manager for X in the spirit of dwm"
HOMEPAGE="http://www.rootshell.be/~polachok/code/"
SRC_URI="http://www.rootshell.be/~polachok/code/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXft"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS = -Os/CFLAGS += -g/" \
		-e "s/LDFLAGS = -s/LDFLAGS += -g/" \
		config.mk || die "sed failed"

	epatch "${FILESDIR}"/"${P}"-modkey.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	doman ${PN}.1
	dodoc README
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
	elog "${PREFIX}/usr/share/examples/${PN}/"
	elog "Copy this folder to ~/.${PN}/ and modify the echinusrc as you wish."
	elog ""
	elog "For changing the modkey you can use \"Echinus*modkey: X\""
	elog "in echinusrc. Replace the X with the number you want to use,"
	elog "1 is for Mod1Mask, 2 for Mod2Mask and so on."
}
