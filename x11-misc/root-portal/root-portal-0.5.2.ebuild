# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/root-portal/root-portal-0.5.2.ebuild,v 1.8 2007/01/05 04:49:53 dirtyepic Exp $

inherit gnome2

DESCRIPTION="A program to draw text and graphs in the root window"
HOMEPAGE="http://root-portal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
DOC="PACKAGING README NEWS ChangeLog BUGS AUTHORS README.help TODO"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/libzvt-2
	>=gnome-base/orbit-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	x11-libs/libXpm
	dev-libs/libxml"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.patch"

}

src_install() {

	# stupid sandboxing
	einstall || die "einstall failed"

}
