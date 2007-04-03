# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/linuxdcpp/linuxdcpp-20070403.ebuild,v 1.1 2007/04/03 13:53:00 armin76 Exp $

inherit eutils

DESCRIPTION="Direct connect client, looks and works like famous DC++"
HOMEPAGE="http://linuxdcpp.berlios.de"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

S="${WORKDIR}/${PN}"

RDEPEND=">=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.6
	app-arch/bzip2"

DEPEND="${RDEPEND}
	>=dev-util/scons-0.96
	dev-util/pkgconfig"

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

	make_desktop_entry ${PN} "${PN}" ${PN}.png
}

pkg_postinst() {
	elog
	elog "After adding first directory to shares you might need to restart linuxdcpp."
	elog
}
