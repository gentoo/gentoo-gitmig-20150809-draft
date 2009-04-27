# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/linuxdcpp/linuxdcpp-9999.ebuild,v 1.11 2009/04/27 18:26:45 armin76 Exp $

inherit bzr eutils

DESCRIPTION="Direct connect client, looks and works like famous DC++"
HOMEPAGE="http://linuxdcpp.berlios.de"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

EBZR_REPO_URI="lp:linuxdcpp"

S="${WORKDIR}/${P}"

RDEPEND=">=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.6
	app-arch/bzip2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	media-libs/fontconfig
	>=dev-util/scons-0.96
	dev-util/pkgconfig
	>=dev-libs/boost-1.35.0-r2"

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} debug=1"

	scons ${myconf} ${MAKEOPTS} CXXFLAGS="${CXXFLAGS}" PREFIX=/usr || die "scons failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ${PN} pixmaps glade

	dodoc Readme.txt Changelog.txt Credits.txt

	dosym /usr/share/${PN}/${PN} /usr/bin/${PN}
	fperms +x /usr/share/${PN}/${PN}

	doicon pixmaps/${PN}.png

	make_desktop_entry ${PN} "${PN}" ${PN}
}

pkg_postinst() {
	elog
	elog "After adding first directory to shares you might need to restart linuxdcpp."
	elog
}
