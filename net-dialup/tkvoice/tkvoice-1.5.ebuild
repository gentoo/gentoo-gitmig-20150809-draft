# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/tkvoice/tkvoice-1.5.ebuild,v 1.2 2006/04/02 14:03:30 mrness Exp $

DESCRIPTION="TkVoice - Voice mail and Fax frontend program"
HOMEPAGE="http://tkvoice.netfirms.com"
SRC_URI="http://tkvoice.netfirms.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/tk
		media-libs/netpbm
		media-sound/sox
		net-dialup/mgetty"

src_unpack() {
	unpack ${A}

	sed -i -e "s:/usr/local/etc:/etc:g; s:/usr/local/bin:/usr/bin:g; s:/usr/local/tkvoice:/usr/lib/${P}:g" \
		"${S}/tkvoice" "${S}/TCL/tkvfaq.tcl" "${S}/TCL/tkvsetupvoice.tcl"
	sed -i -e "s:set STARTDIR .*:set STARTDIR /usr/lib/${P}:" \
		"${S}/tkvoice"
}

src_install()
{
	exeinto /usr/lib/${P}
	doexe ${PN}
	dodir /usr/bin
	dosym /usr/lib/${P}/${PN} /usr/bin/${PN}
	insinto /usr/lib/${P}/TCL
	doins TCL/*
	insinto /usr/lib/${P}/image
	doins image/*

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
	insinto /usr/share/pixmaps
	doins ${PN}.xpm

	dodoc BUGS FAQ README TODO
}

pkg_postinst()
{
	einfo "${P} has been installed. Run /usr/bin/${PN}."
	einfo "For more information, see the home page, ${HOMEPAGE}"
	einfo "or consult the documentation for this program as well as"
	einfo "for mgetty/vgetty."
}
