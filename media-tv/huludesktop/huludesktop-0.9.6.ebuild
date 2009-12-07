# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/huludesktop/huludesktop-0.9.6.ebuild,v 1.1 2009/12/07 16:41:20 vapier Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Hulu desktop"
HOMEPAGE="http://www.hulu.com/labs/hulu-desktop-linux"
SRC_URI="amd64? ( http://download.hulu.com/${PN}_amd64.deb -> ${P}_amd64.deb )
	x86? ( http://download.hulu.com/${PN}_i386.deb -> ${P}_i386.deb )"

LICENSE="Hulu-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lirc"
RESTRICT="mirror strip"

RDEPEND="sys-libs/glibc
	sys-libs/zlib
	www-plugins/adobe-flash
	x11-libs/gtk+:2
	dev-libs/glib:2
	lirc? ( app-misc/lirc )"

QA_EXECSTACK="opt/bin/huludesktop.bin"

src_unpack() {
	unpack ${A} ./data.tar.gz
}

src_install() {
	insinto /etc/${PN}
	doins etc/${PN}/hd_keymap.ini || die

	dobin "${FILESDIR}"/${PN} || die
	into /opt
	newbin usr/bin/${PN} ${PN}.bin || die

	domenu usr/share/applications/${PN}.desktop || die
	doicon usr/share/pixmaps/${PN}.png || die
	dodoc usr/share/doc/${PN}/README || die
}
